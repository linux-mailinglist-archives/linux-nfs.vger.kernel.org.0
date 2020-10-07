Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A16285F88
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 14:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgJGM4E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 08:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbgJGM4E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 08:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602075362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAukPWjVRphjO9TzgW6qLjhVzdawIp1UNIH7Q41Oaxk=;
        b=KG77Tkwk5cQJb3KfQzbyPuwcXeGcPx64ljNB1MWSSlA+p/TlcU+qtV6fvjD6QmILnbiwQb
        PTkvUjIrtJ8X4i9WMTCw/ZWlXFLpGZGPODlfM1rFHGRTFkf1+7tahSVnz/YAC+5+S+04Lg
        Mf+J+TTdxrL+mpgoVSi6dmU1T9fRY5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-iafsv85xNJmwdE_mPeEXcA-1; Wed, 07 Oct 2020 08:56:01 -0400
X-MC-Unique: iafsv85xNJmwdE_mPeEXcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C74196C907;
        Wed,  7 Oct 2020 12:55:57 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B78010002B5;
        Wed,  7 Oct 2020 12:55:57 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Olga Kornievskaia" <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Date:   Wed, 07 Oct 2020 08:55:56 -0400
Message-ID: <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
In-Reply-To: <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
References: <20201006151335.GB28306@fieldses.org>
 <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Oct 2020, at 7:27, Benjamin Coddington wrote:

> On 6 Oct 2020, at 20:18, J. Bruce Fields wrote:
>
>> On Tue, Oct 06, 2020 at 05:46:11PM -0400, Olga Kornievskaia wrote:
>>> On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington 
>>> <bcodding@redhat.com> wrote:
>>>>
>>>> On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:

>> Looks like nfs4_init_{non}uniform_client_string() stores it in
>> cl_owner_id, and I was thinking that meant cl_owner_id would be used
>> from then on....
>>
>> But actually, I think it may run that again on recovery, yes, so I 
>> bet
>> changing the nfs4_unique_id parameter midway like this could cause 
>> bugs
>> on recovery.
>
> Ah, that's what I thought as well.  Thanks for looking closer Olga!

Well, no -- it does indeed continue to use the original cl_owner_id.  We
only jump through nfs4_init_uniquifier_client_string() if cl_owner_id is
NULL:

6087 static int
6088 nfs4_init_uniform_client_string(struct nfs_client *clp)
6089 {
6090     size_t len;
6091     char *str;
6092
6093     if (clp->cl_owner_id != NULL)
6094         return 0;
6095
6096     if (nfs4_client_id_uniquifier[0] != '\0')
6097         return nfs4_init_uniquifier_client_string(clp);
6098


Testing proves this out as well for both EXCHANGE_ID and SETCLIENTID.

Is there any precedent for stabilizing module parameters as part of a
supported interface?  Maybe this ought to be a mount option, so client 
can
set a uniquifier per-mount.

Ben

