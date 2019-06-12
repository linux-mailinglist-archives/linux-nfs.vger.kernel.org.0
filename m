Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8783F42502
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406289AbfFLMHk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 08:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405914AbfFLMHj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 08:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98F9530872C3;
        Wed, 12 Jun 2019 12:07:39 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46F9D5D961;
        Wed, 12 Jun 2019 12:07:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Jianchao Wang" <jianchao.wan9@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Can we setup pNFS with multiple DSs ?
Date:   Wed, 12 Jun 2019 08:07:38 -0400
Message-ID: <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
In-Reply-To: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
References: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 12:07:39 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jianchao,

On 12 Jun 2019, at 3:55, Jianchao Wang wrote:

> Hi
>
> I'm trying to setup a pNFS experiment environment.
> And this is what I have got,
> VM-0 (DS)      running a iscsi target
> VM-1 (MS)      initiator, mount a XFS on the device, and export it by 
> NFS with pnfs option
> VM-2 (Client)  initiator, but not mount, running a blkmapd
>                mount the shared directory of VM-1 by NFS
>
> And it semes to work well as the mountstatus
>             LAYOUTGET: 14 14 0 3472 2744 1 1381 1384
> 	GETDEVICEINFO: 1 1 0 196 148 0 5 5
> 	 LAYOUTCOMMIT: 8 8 0 2352 1368 0 1256 1257
>
> The kernel version I use is 4.18.19.
>
> And would anyone please help to clarify following questions ?
> 1. Can I involve multiple DSs here ?

Yep, you can add a new iSCSI DS with another filesystem and keep the 
same
MD.  The pNFS SCSI layout has support for multi-device layouts, but I 
don't
think anyone has put them through the paces.

The sweet spot for pNFS SCSI is large-scale FC where the fabric allows 
nodes
different paths through different controllers.  I expect the 
do-it-yourself
with iSCSI target on linux to have a bit more limited performance 
benefits.

> 2. Is this stable enough to use in production ? How about earlier 
> version, for example 4.14 ?

Test it!  It would be great to have more users.

It would also be great to hear about your workload and if this shows any
improvements.

Last note - with SCSI layouts, there's no need to run blkmapd.  The 
kernel
should have all the info it needs to find the correct SCSI devices.

Ben
