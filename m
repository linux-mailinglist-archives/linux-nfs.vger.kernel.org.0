Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5372E5D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2019 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfGXMDS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Jul 2019 08:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfGXMDS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Jul 2019 08:03:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 166743082135;
        Wed, 24 Jul 2019 12:03:18 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BED6E600D1;
        Wed, 24 Jul 2019 12:03:17 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Diyu Zhou" <zhoudiyupku@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Write Delegation
Date:   Wed, 24 Jul 2019 08:03:17 -0400
Message-ID: <F3561F20-F689-4E12-BB31-F3BEAD529743@redhat.com>
In-Reply-To: <CAH19VSHOxn-S8bc88fgZn8K1yw5=a9=m1YQBcCt9Ro_MPZVC_A@mail.gmail.com>
References: <CAH19VSHOxn-S8bc88fgZn8K1yw5=a9=m1YQBcCt9Ro_MPZVC_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 24 Jul 2019 12:03:18 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Jul 2019, at 17:21, Diyu Zhou wrote:

> Hey,
>
> I just started studying the Linux NFS code and I found the comments on 
> file
> /fs/nfsd/nfs4state.c right above function nfs4_open_delegation, 
> saying: "
> Attempt to hand out a delegation. Note we don't support write 
> delegations, and
> won't until the vfs has proper support for them."
>
> Does that mean the current implementation of nfs4 in Linux does not 
> support
> write delegation?

Hi Diyu,

The linux NFS server does not give out write delegations yet, but the 
linux
NFS client is capable of using them.

Ben
