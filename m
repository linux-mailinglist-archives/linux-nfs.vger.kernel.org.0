Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72861F4283
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 09:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfKHIrw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 8 Nov 2019 03:47:52 -0500
Received: from mail2.xel.nl ([82.94.246.102]:58226 "EHLO mail2.xel.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfKHIrv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 03:47:51 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 03:47:50 EST
Received: from localhost (localhost [127.0.0.1])
        by mail2.xel.nl (Postfix) with ESMTP id 17972E2B18
        for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2019 09:41:40 +0100 (CET)
X-Virus-Scanned: Scanned by Xel Media mail2
Received: from mail2.xel.nl ([127.0.0.1])
        by localhost (mail2.xel.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2_BU-9hTmBts for <linux-nfs@vger.kernel.org>;
        Fri,  8 Nov 2019 09:41:39 +0100 (CET)
Received: from 2001-41f0-40ca-0001-9100-6368-9af4-6769.static.v6.ziggozakelijk.nl (2001-41f0-40ca-0001-9100-6368-9af4-6769.static.v6.ziggozakelijk.nl [IPv6:2001:41f0:40ca:1:9100:6368:9af4:6769])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail2.xel.nl (Postfix) with ESMTPSA id 7A6B6E04F2
        for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2019 09:41:39 +0100 (CET)
From:   Samy Ascha <samy@ascha.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Specific IP per mounted share from same server
Message-Id: <5DBD272A-0D55-4D74-B201-431D04878B43@ascha.org>
Date:   Fri, 8 Nov 2019 09:41:36 +0100
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

I have an NFS server with 2 NICs, configured on different subnets. These subnets are on different network segments (2 dedicated switches).

I have clients that mount 2 distinct shares from this server. Expecting to spread the network load, I specified the mounts like so, in fstab:

10.110.1.235:/srv/nfs/www    /var/www    nfs defaults,rw,intr,nosuid,noatime,vers=4.1 0 0
10.110.0.235:/srv/nfs/backup    /backup   nfs defaults,rw,intr,nosuid,noatime,vers=4.1 0 0

However, as you may find totally expected, I see both mounts connected to the same IP on the server. Specificly, the one specified for the first mount:

10.110.1.235:/srv/nfs/www on /var/www type nfs4 (rw,...)
10.110.1.235:/srv/nfs/backup on /backup type nfs4 (rw,...)

Is this expected? Am I wrong to assume that this is a possible setup? If possible/forcible, what am I missing / doing wrong? :)

Thanks much,
Samy
