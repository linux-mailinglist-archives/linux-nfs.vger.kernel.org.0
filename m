Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3171A991D
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895710AbgDOJjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 05:39:23 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:48188 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895690AbgDOJjV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Apr 2020 05:39:21 -0400
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id D4283160778
        for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2020 11:39:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de D4283160778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1586943556; bh=xrURf8aMpSJGTGLubuCcf69I263xbUFCf/wrrboNeNE=;
        h=Date:From:To:Subject:From;
        b=ywWnH99Xp3RIZ7EFjgwzRhwcGLZD6IaklrTBQKbciOmZa4SW/b9yzz9YhmHY9F7dy
         Ur9aN5f7HzIvdptLSvfFAFCAQl8zat22e80eZZgWJIfWnMHQlmuJLrUEIdKrC5CZWq
         ll5dQrR8/vNHIeKq3Wx3f7Ti59CGJpL/U3SHck1c=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id D039E1A0101
        for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2020 11:39:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id A93A4C008A
        for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2020 11:39:16 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:39:16 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <563971101.12407489.1586943556660.JavaMail.zimbra@desy.de>
Subject: multiple EXCHANGE_ID diring a mount.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Index: noP7bN9i69FFVyqBi2IgCdXjpu5SMA==
Thread-Topic: multiple EXCHANGE_ID diring a mount.
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Dear NFS (client) developers,

Today I notice, that during mount nfs client sends two  EXCHANGE_ID operati=
ons:


    4 0.000380551 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 NULL Cal=
l
    6 0.001052087 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 NULL Rep=
ly (Call In 4)
    8 0.001501687 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call EXC=
HANGE_ID
    9 0.002105356 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (C=
all In 8) EXCHANGE_ID
   11 0.002489297 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call EXC=
HANGE_ID <----------------------------------- A second one
   12 0.003422630 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (C=
all In 11) EXCHANGE_ID
   14 0.003569542 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call CRE=
ATE_SESSION
   17 0.004701642 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (C=
all In 14) CREATE_SESSION
   18 0.004822235 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call REC=
LAIM_COMPLETE
   19 0.005317324 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (C=
all In 18) RECLAIM_COMPLETE
   20 0.005489908 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call SEC=
INFO_NO_NAME
   21 0.006648815 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (C=
all In 20) SECINFO_NO_NAME


I observe this with kernel 5.6 and 5.5. On opposite, the older kernels, lik=
e in RHEL7 don't do this

Older kernel (3.10.0-1062.12.1.el7.x86_64)

$ tshark -r ex_id_el7.pcap -Y nfs
  8 0.006731652 131.169.240.106 -> 131.169.240.145 NFS 336 V4 Call EXCHANGE=
_ID
  9 0.008812988 131.169.240.145 -> 131.169.240.106 NFS 224 V4 Reply (Call I=
n 8) EXCHANGE_ID
 10 0.009127689 131.169.240.106 -> 131.169.240.145 NFS 292 V4 Call CREATE_S=
ESSION
 13 0.012583411 131.169.240.145 -> 131.169.240.106 NFS 196 V4 Reply (Call I=
n 10) CREATE_SESSION
 14 0.012805867 131.169.240.106 -> 131.169.240.145 NFS 208 V4 Call RECLAIM_=
COMPLETE
 15 0.013716790 131.169.240.145 -> 131.169.240.106 NFS 160 V4 Reply (Call I=
n 14) RECLAIM_COMPLETE
 16 0.013981538 131.169.240.106 -> 131.169.240.145 NFS 216 V4 Call SECINFO_=
NO_NAME
 17 0.019359329 131.169.240.145 -> 131.169.240.106 NFS 176 V4 Reply (Call I=
n 16) SECINFO_NO_NAME


This is of course not a big problem, but can point to an unintended change =
or error. The capture
file available at:

https://sas.desy.de/index.php/s/3sRA9WD5BEpZH7z

Regards,
   Tigran.
