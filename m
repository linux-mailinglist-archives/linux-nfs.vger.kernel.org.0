Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32475D7A9
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jul 2023 00:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGUWqj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 18:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGUWqi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 18:46:38 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 15:46:37 PDT
Received: from smtp-lb.pixar.com (smtp-lb.pixar.com [138.72.247.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484A3A8E
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 15:46:37 -0700 (PDT)
DomainKey-Signature: s=emeryville; d=pixar.com; c=nofws; q=dns;
  h=Authentication-Results:IronPort-SDR:X-PixarMID:
   X-PixarRecvListener:X-PixarRemoteIP:X-PixarMailFlowPolicy:
   Received:Date:From:To:Subject:Message-ID:User-Agent;
  b=XlZOpKfXe8jkwOal9rd3J/whNrcF3OKmVp2+Sul3L27Dp0z4tQaTtwGL
   py0wqSrcAMKIZiLzhW6cDGY8iyD+1C2+PRwce8g8aviPrDFbjqkXVc5lD
   CShDZ6lOXeb99jXMgVMf7AijFP+bCuDUGKqOH5m3JiwHNi1i1rHGGV8H6
   2QOzBf0nuXm9SA6UQOokq5ju2PjX3mVtrMeFmJcxCKO0HAf1MFDXO32x6
   NOdbshypYNuIncNrH77oq3GYwYSskw+FvxypPeyrk396TSuhAtF4dOApP
   lMUeIFPywVgCHQblTJKkeWU56DLmf045N4Y588OqXKVwna2EUggb0M1Rp
   A==;
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=pixar.com; i=@pixar.com; q=dns/txt; s=dkimdefault;
  t=1689979597; x=1721515597;
  h=date:from:to:subject:message-id;
  bh=rtm/13IaEWLwGw6fDTEZWeGdUcfqzSb4COY+z75ySWE=;
  b=pp1354sAG/0EQbcTDRvw1E6DlgbbgOjecautBYwpaxBWDQxKqu4VHRmi
   87ZJ692mP8NDDUbij+eJiHcCpf7GdH9iSaiN5ZSnxBK1eiUeyZNAsgWqd
   AOk3vi4t8KO+OxdB1LArvhZCeKGuE6qER0XQ3AG7Xk9MTDKwioAM7+Ist
   15SpZQcVkjckLQD6KVUVsp6Tuiy56mLdnuqyP2q3B/j03dfakWcEeLDK6
   wG6DIfSP/BUmiXbn81gVL0UIXxiu5ojViF5K7GZItaacVQURB5AVBZ7In
   yno6jTmjIRj9furUfTjeDyydONMbjte90xIXbF+wlM9ub65yupdbrlxQG
   Q==;
Authentication-Results: smtp-lb.pixar.com; dkim=none (message not signed) header.i=none
IronPort-SDR: IwJ56G2YYtKlIkbqQzfOAXOGiAFKz4LipS4wkANmTqNVffLwp85+Wa1Fk/IXHoIaz7IOjB59ky
 sYgVnT+aX5Tg==
X-PixarMID: 106817265
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.53.70
X-PixarMailFlowPolicy: $RELAYED
Received: by belboz.pixar.com (Postfix, from userid 1690)
        id A04056017A94; Fri, 21 Jul 2023 15:45:30 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:45:30 -0700
From:   lars@pixar.com
To:     linux-nfs@vger.kernel.org
Subject: Best kernel function to probe for NFS write accounting?
Message-ID: <20230721224530.I6e45%lars@pixar.com>
User-Agent: s-nail v14.9.22
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I'm using BPF to do NFS operation accounting for user-space processes. I'd like
to include the number of bytes read and written to each file any processes open
over NFS.

For write operations, I'm currently using an fexit probe on the
nfs_writeback_done function, and my program appears to be getting the
information I'm hoping for. But I can see that under some circumstances the
actual operations are being done by kworker threads, and so the PID reported by
the BPF program is for that kworker instead of the user-space process that
requested the write.

Is there a more appropriate function to probe for this information if I only
want it triggered in context of the user-space process that performed the
write? If not, I'm wondering if there's enough information in a probe triggered
in the kworker context to track down the user-space PID that initiated the
writes.

I didn't find anything related in the kernel's Documentation directory, and I'm
not yet proficient enough with the vfs, nfs, and sunrpc code to find an
appropriate function myself.

If it matters, our infrastructure is all based on NFSv3.

Thanks for any leads or documentation pointers!
Lars
