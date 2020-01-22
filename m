Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF1145050
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgAVJor (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 04:44:47 -0500
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:44556 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388091AbgAVJoq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 04:44:46 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2020 04:44:45 EST
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <felix@kngnt.org>)
        id 1iuCDJ-00012z-L1
        for linux-nfs@vger.kernel.org; Wed, 22 Jan 2020 10:22:17 +0100
Received: from 94-209-183-118.cable.dynamic.v4.ziggo.nl ([94.209.183.118] helo=mail.kngnt.org)
        by smtp7.tb.mail.iss.as9143.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <felix@kngnt.org>)
        id 1iuCDJ-0004mf-IL
        for linux-nfs@vger.kernel.org; Wed, 22 Jan 2020 10:22:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kngnt.org; s=mail;
        t=1579684937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qy6Mr39p5Tp2QH6VA0ANOcvP4Xw3EKDIUUD0ZwxinI4=;
        b=eaZDNVH1xO6st52ymcuDXJd6C7O7z2VLCFeaDhYUfnkzRdwWgCq52Mxw92lwXSk7iBXLwB
        d/NY1iVHgEaMds/QOqZgGf70SuMdTEyXJSV90mSYweY4vRP+1yGT95E1I8rBpZOIpyzcuO
        Iolux8NB3m9DjLMwNEZgauYuTf6jPsebVGtFBcDxw2VGHm9E6gKq4dOuxNuUOO7NKZFZk7
        vVCLo56EAq8aRO161Q3+LAMQ4dBCJgGvvdXL8Yi+nNIOl1aToyI10uahPjIix+I4J2w2uj
        ruvwzF/cvjXtxWDJ7iPv4/j6Y/GZ25kaotaA56yTPMt6TKz++PzlDucp7uVH5Q==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jan 2020 10:22:16 +0100
From:   Felix Rubio <felix@kngnt.org>
To:     linux-nfs@vger.kernel.org
Subject: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Message-ID: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
X-Sender: felix@kngnt.org
X-SourceIP: 94.209.183.118
X-Authenticated-Sender: f.rubiodalmau@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=Aa/P4EfG c=1 sm=1 tr=0 a=KDOoBKh8T/kja8HrlTi2+A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10 a=mQPdC1LqiykaSo9NeYYA:9 a=QEXdDO2ut3YA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everybody,

I have a kerberized NFSv4 server that is exporting a mountpoint:

     /home 10.0.0.0/8(rw,no_subtree_check,sec=krb5:krb5i:krb5p)

if I mount that export with this command on the client, it works as 
expected:

     /sbin/mount.nfs4 NFS.domain:/home /network/home -o 
_netdev,noatime,hard,sec=krb5

However, if I modify the export to be

     /home 10.0.0.0/8(rw,no_subtree_check,sec=sys:krb5:krb5i:krb5p)

and I mount that export with sec=sys, as

     /sbin/mount.nfs4 NFS.domain:/home /network/home -o 
_netdev,noatime,hard,sec=sys

I get the following error:

     mount.nfs4: timeout set for Fri Jan 17 14:11:32 2020
     mount.nfs4: trying text-based options 
'hard,sec=sys,vers=4.1,addr=10.2.2.9,clientaddr=10.2.0.12'
     mount.nfs4: mount(2): Operation not permitted
     mount.nfs4: Operation not permitted

What might be the reason for this behavior?

-- 
Felix Rubio
"Don't believe what you're told. Double check."
