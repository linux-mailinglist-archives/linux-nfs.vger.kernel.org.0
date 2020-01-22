Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A800145B9A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgAVSaq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 13:30:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgAVSaq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 13:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579717844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0c3KW1Gf/rOv5QLeyTsSgXdAWXcQuFxduG35kz3RGo=;
        b=bXpu8K1b2sIM+yz6o/NW9PeK5dQvOA7LF7fpPpWj3FU14VKXm5lKUVlQ552nk3dhRNwBrA
        NSKhVNiKeKVjaiEpUWN58R6/JBo9D59evVeFlgpeIA0KzS2wwRJTfW942k/8N6fsJpS4w0
        3QFd74GnkozrkfPBCRGzJ1Q7Bod0L+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-AvxvDFfpO4yvKVjxztzWoA-1; Wed, 22 Jan 2020 13:30:26 -0500
X-MC-Unique: AvxvDFfpO4yvKVjxztzWoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A7210054E3;
        Wed, 22 Jan 2020 18:30:25 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94C0319C5B;
        Wed, 22 Jan 2020 18:30:25 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Felix Rubio" <felix@kngnt.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Date:   Wed, 22 Jan 2020 13:30:24 -0500
Message-ID: <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
In-Reply-To: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Jan 2020, at 4:22, Felix Rubio wrote:

> Hi everybody,
>
> I have a kerberized NFSv4 server that is exporting a mountpoint:
>
>     /home 10.0.0.0/8(rw,no_subtree_check,sec=krb5:krb5i:krb5p)
>
> if I mount that export with this command on the client, it works as 
> expected:
>
>     /sbin/mount.nfs4 NFS.domain:/home /network/home -o 
> _netdev,noatime,hard,sec=krb5
>
> However, if I modify the export to be
>
>     /home 10.0.0.0/8(rw,no_subtree_check,sec=sys:krb5:krb5i:krb5p)
>
> and I mount that export with sec=sys, as
>
>     /sbin/mount.nfs4 NFS.domain:/home /network/home -o 
> _netdev,noatime,hard,sec=sys
>
> I get the following error:
>
>     mount.nfs4: timeout set for Fri Jan 17 14:11:32 2020
>     mount.nfs4: trying text-based options 
> 'hard,sec=sys,vers=4.1,addr=10.2.2.9,clientaddr=10.2.0.12'
>     mount.nfs4: mount(2): Operation not permitted
>     mount.nfs4: Operation not permitted
>
> What might be the reason for this behavior?

Hi Felix,

I don't know.  Can you get more information?  Try again after `rpcdebug 
-m
nfs -s mount`.  That will turn up debugging for messages labeled for 
mount,
and the output will be in the kernel log.  There are other facilities 
there,
see rpcdebug(8).

Another good option is getting a network capture of the mount attempt 
and
trying to figure out if the server is returning an error, or the client 
is
generating the error.

There are also a lot of "nfs", "nfs4", and "rpc" tracepoints you can 
enable
to get more information.

Ben

