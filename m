Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7229D212B9C
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2020 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGBRwp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jul 2020 13:52:45 -0400
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:47410 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgGBRwo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jul 2020 13:52:44 -0400
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <felix@kngnt.org>)
        id 1jr3O6-0001de-Nm; Thu, 02 Jul 2020 19:52:42 +0200
Received: from 94-209-183-118.cable.dynamic.v4.ziggo.nl ([94.209.183.118] helo=mail.kngnt.org)
        by smtp6.tb.mail.iss.as9143.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <felix@kngnt.org>)
        id 1jr3O6-00FHh2-Eb; Thu, 02 Jul 2020 19:52:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kngnt.org; s=mail;
        t=1593712361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CXYRZjwhr+U4STstadhTct0C/Gy24S2AWu/qx+/Rkw=;
        b=Kk8QprG2CoNc3KuC02FjrLjyt4NUOjI3VlC99BkJ5/TB4nRC8sbCogTRKzdPRWEWyw4VOP
        yW0Z8EjK6yjX1nUxrh9JggpfqlfQeNNxeG3pnIjBD9EtR5o9ngIqDwRpaCshBzvd5Ch1uM
        8W1RLRniG2THH9kB/a3NOeIuTTz5haKg590HmPVc5ZnlRomrMDNDIezwylFiH0gOSIS+Qq
        tatHgijGC0Lzx2TgU1JF9zRihu1ktvVrLA16x2koJplvYJO2QSNdupQRYIMB+m7MCAZZVu
        eKyDua7wZrXSOqCzIco6OI4mx8BP7c/64HhgGFPKK7zrOVMU20dLo2uk2pLSkg==
From:   Felix Rubio <felix@kngnt.org>
To:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when mounting with sec=sys
Date:   Thu, 02 Jul 2020 19:52:41 +0200
Message-ID: <4097833.BOCuNxM56l@polaris>
In-Reply-To: <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org> <9e25861022acb796c35d3adb392bf4c4@kngnt.org> <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-SourceIP: 94.209.183.118
X-Authenticated-Sender: f.rubiodalmau@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=KbhJTTQD c=1 sm=1 tr=0 a=KDOoBKh8T/kja8HrlTi2+A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=anwlzUk7Dk_UhlGP9qEA:9 a=CjuIK1q_8ugA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you Dai,

Your guess is absolutely correct: Right after I send the mail, I noted that... I set it the /exports (fsid=0) to sec=*sys:*krb5:krb5i:krb5p, and then I set the depending FS to the options I wanted: fixed. I even told Benjamin Coddington, out of the happines for having solved it (it was really making me go nuts), but I forgot to tell the mailing list. Sorry for that!

Thank you very much, guys!

Felix


