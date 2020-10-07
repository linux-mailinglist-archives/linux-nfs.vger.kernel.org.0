Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9622F285E12
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgJGL1d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 07:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgJGL1d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 07:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602070052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDd15FcD4jbZJobjtZjKJ8aW+zrR3z7+6xOSXHLX3/o=;
        b=FYSB/qVMoyWzs6nVGU+Am+9nsa5ItCrfBD7GNeY6hNrhQJQRCxjfv6bdVnffEroyrX7lUn
        p2gBIEw9EZuHtPBJpuk5Bqro+VJIudX75S0f3NuQE7H62zSqobXdj2Dkk+wukUHyWaPpQT
        vQhdnXifhTHRuGNtSa5XBGjdnlFR2HM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-mpDc0DVdNHqEmB4oYwc3Fg-1; Wed, 07 Oct 2020 07:27:29 -0400
X-MC-Unique: mpDc0DVdNHqEmB4oYwc3Fg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 334DE87950B;
        Wed,  7 Oct 2020 11:27:28 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B79881002382;
        Wed,  7 Oct 2020 11:27:27 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Olga Kornievskaia" <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Date:   Wed, 07 Oct 2020 07:27:26 -0400
Message-ID: <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
In-Reply-To: <20201007001814.GA5138@fieldses.org>
References: <20201006151335.GB28306@fieldses.org>
 <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Oct 2020, at 20:18, J. Bruce Fields wrote:

> On Tue, Oct 06, 2020 at 05:46:11PM -0400, Olga Kornievskaia wrote:
>> On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>>
>>> On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:
>>>
>>>> NFSv4.1+ differs from earlier versions in that it always performs
>>>> trunking discovery that results in mounts to the same server 
>>>> sharing a
>>>> TCP connection.
>>>>
>>>> It turns out this results in performance regressions for some 
>>>> users;
>>>> apparently the workload on one mount interferes with performance of
>>>> another mount, and they were previously able to work around the
>>>> problem
>>>> by using different server IP addresses for the different mounts.
>>>>
>>>> Am I overlooking some hack that would reenable the previous 
>>>> behavior?
>>>> Or would people be averse to an "-o noshareconn" option?
>>>
>>> I suppose you could just toggle the nfs4_unique_id parameter.  This
>>> seems to
>>> work:
>>>
>>> flock /sys/module/nfs/parameters/nfs4_unique_id bash -c 
>>> "OLD_ID=\$(cat
>>> /sys/module/nfs/parameters/nfs4_unique_id); echo imalittleteapot >
>>> /sys/module/nfs/parameters/nfs4_unique_id; mount -ov4,sec=sys
>>> 10.0.1.200:/exports /mnt/fedora2; echo \$OLD_ID >
>>> /sys/module/nfs/parameters/nfs4_unique_id"
>>>
>>> I'm trying to think of a reason why this is a bad idea, and not 
>>> coming
>>> up
>>> with any.  Can we support users that have already found this 
>>> solution?
>>>
>>
>> What about reboot recovery? How will each mount recover its own state
>> (and present the same identifier it used before). Client only keeps
>> track of one?
>
> Looks like nfs4_init_{non}uniform_client_string() stores it in
> cl_owner_id, and I was thinking that meant cl_owner_id would be used
> from then on....
>
> But actually, I think it may run that again on recovery, yes, so I bet
> changing the nfs4_unique_id parameter midway like this could cause 
> bugs
> on recovery.

Ah, that's what I thought as well.  Thanks for looking closer Olga!

I don't see why we couldn't store it for the duration of the mount, and
doing so would fix reboot recovery when the uniquifier is changed after 
a
mount.

Ben

