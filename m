Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2F13DFEE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAPQVl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 11:21:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728249AbgAPQVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 11:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579191699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOB951G7dCGKDeI4y10UzZpE6TE9epQjJFRJCKc/H3c=;
        b=hDUuflL9sEbPl7wGeKPNSxkzv/G0exa+ysBWyZf4yb7qLUlEPfKJ0GvVmSdWhthh8aUORE
        FXtRcy4SEYujabYEMSHfFDlSucMN6AEOEZVG3qPKxoaQjbx9Mlucm/gb5tKcngeCGh3vbl
        eWMaHZ2qpiZdNwYQXD4kPMLIE28J1eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-6GL_Dg9CNrmgE020i3yLsw-1; Thu, 16 Jan 2020 11:21:38 -0500
X-MC-Unique: 6GL_Dg9CNrmgE020i3yLsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F865A0CC0;
        Thu, 16 Jan 2020 16:21:36 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5990219C5B;
        Thu, 16 Jan 2020 16:21:36 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Lookup revalidation for OPEN_CLAIM_FH
Date:   Thu, 16 Jan 2020 11:21:35 -0500
Message-ID: <843EF573-3305-4490-B084-827F9FB87077@redhat.com>
In-Reply-To: <3a91fb298d29c17c76e2bce1a190110cd6fe72c0.camel@hammerspace.com>
References: <31B20BC3-A089-47F9-9821-7A3543FF7413@redhat.com>
 <7eae4162d7c8a85bbb7fddab3a818472ec2ebc54.camel@hammerspace.com>
 <C69931E7-7465-4662-91AC-C74609A4CDB2@redhat.com>
 <3a91fb298d29c17c76e2bce1a190110cd6fe72c0.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Jan 2020, at 10:38, Trond Myklebust wrote:

> On Thu, 2020-01-16 at 10:13 -0500, Benjamin Coddington wrote:
>> On 16 Jan 2020, at 9:35, Trond Myklebust wrote:
>
> nfs_file_open() is completely the wrong place to perform a lookup. Its
> purpose in the VFS is to allow the filesystem to set up state *after*
> we've already looked up the dentry, revalidated it and therefore
> decided which file to open.
> The NFSv4.0 behaviour of performing a new lookup is actually the
> aberration here, and is due to the fact that it does not have an open-
> by-filehandle operation, so we have no alternative.

Ok, that makes good sense to me.

> As I said, if you want stronger semantics, there are lookupcache mount
> options that allow you to tune things. I therefore see no valid reason
> to change the existing behaviour, which also matches that of older NFS
> versions (i.e. v3 and v2).

Thanks for the discussion.  Your point above about v4.0 CLAIM_NULL actually
doing another lookup after we already did a lookup throws things in sharp
relief.

Ben

