Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87C6066EB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Oct 2022 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJTRTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Oct 2022 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJTRTH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Oct 2022 13:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E71D79BA
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666286345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+1VJKvQ64gmQLT5pRI8etc5uGtTLhS05M3Tp9kQtVQ=;
        b=dhPiWYqxG8w/9laF7PJ7ahaUBzcJ2kQkWf0JFhzpMYCGLKw6e3DDDdiYy30skUW/woBaHD
        cXBARRhPD7rv/k83Tq+6psWDk9PpZk2ooWULlVsiU7YD2ZSDRL3hQMHvYvg7YxpFOAdZmg
        osIHU3CcAPPmQFd0Rl/R9ZLRLwwOROA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-Qp3MpcWqNBqGwEF9Be9dbQ-1; Thu, 20 Oct 2022 13:19:03 -0400
X-MC-Unique: Qp3MpcWqNBqGwEF9Be9dbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 610F3857AB7;
        Thu, 20 Oct 2022 17:19:03 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C760E1401CC0;
        Thu, 20 Oct 2022 17:19:02 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Andreas Hasenack <andreas@canonical.com>,
        Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Invalid free() in blkmapd, core dump
Date:   Thu, 20 Oct 2022 13:19:00 -0400
Message-ID: <12B9F373-E858-4415-B71D-227FD6D7E4D6@redhat.com>
In-Reply-To: <CANYNYEG=utJ2pe+FtMWh8O+dz63R2wbzOC7ZVrvoqD=U04WL5g@mail.gmail.com>
References: <CANYNYEG=utJ2pe+FtMWh8O+dz63R2wbzOC7ZVrvoqD=U04WL5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Adding Steve D directly to see if he can pick up the original fix.

Steve, what happened to https://lore.kernel.org/linux-nfs/77a09978-a5aa-e=
a7f-04b8-a8d398ee325f@huawei.com/  ?

Ben

On 20 Oct 2022, at 10:33, Andreas Hasenack wrote:

> Hi,
>
> this was brought up before in
> https://www.spinics.net/lists/linux-nfs/msg87598.html
>
> We recently got bug reports about the same issue, and it was only
> yesterday that I finally managed to reproduce it in a VM.
>
> My reproduction steps are:
> - add a scsi device to a vm (not virtio). Maybe works with sata too,
> but scsi reproduced it
> - add it to an LVM VG, and create an LV
> - run blkmapd -f:
> # blkmapd -f
> blkmapd: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No
> such file or directory
> double free or corruption (out)
> Aborted (core dumped)
>
> The "No such file or directory" has nothing to do with it. You can
> "modprobe blocklayoutdriver" to get rid of it, but the invalid free()
> still happens.
>
> in 2.6.1, gdb shows:
> #9  0x00005555555571e5 in bl_add_disk (filepath=3D0x7fffffffd480
> "/dev/dm-2") at device-discovery.c:232
> 232 free(serial->data);
> (gdb) l
> 227 disk->dev =3D dev;
> 228 disk->size =3D size;
> 229 disk->valid_path =3D path;
> 230 }
> 231 if (serial) {
> 232 free(serial->data);
> 233 free(serial);
> 234 }
> 235 }
> 236 return;
>
> As lixiaokeng said in that first post, this should be just
> free(serial). Or use bl_free_scsi_string(), like his suggested patch
> does.

