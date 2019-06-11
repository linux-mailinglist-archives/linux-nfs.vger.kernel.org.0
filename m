Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596E03CC6E
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbfFKNDz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 09:03:55 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:54877 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389958AbfFKNDz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:55 -0400
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 947F3600D9
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 15:03:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 947F3600D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1560258232; bh=CsMAzuFdmNhfVQSO7EcQAOCMvpimJoWCyVHvQ4hJiXI=;
        h=Date:From:To:Cc:Subject:From;
        b=sM67Kd5wrypi/sxzzlor2CWCTp/BKuKsSGsY5ZBYFf1zVsYw9IRrerf5KjACIktgg
         jtub3Pd3TPTl5cKIyRes5WKp80dhik6VxyZ4mkP4pTr32doMiyge2PRBROEllEbgu+
         5KciMrh7RJX6doHgzTWo3HO1NCfXq8g1eZzNVqnc=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 8FE0AA0077;
        Tue, 11 Jun 2019 15:03:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 6AC43C003B;
        Tue, 11 Jun 2019 15:03:52 +0200 (CEST)
Date:   Tue, 11 Jun 2019 15:03:52 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Cc:     zhangliguang@linux.alibaba.com
Message-ID: <2024266154.11538202.1560258232350.JavaMail.zimbra@desy.de>
Subject: Extra READDIR with kernel 5.1
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_11538200_1789860588.1560258232349"
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF67 (Linux)/8.8.10_GA_3786)
Thread-Index: raQR/MgkwKOLJ8uasroI1UgJ9Ku+9Q==
Thread-Topic: Extra READDIR with kernel 5.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_11538200_1789860588.1560258232349
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



Dear NFS fellows,


by inspecting networks trace I have notice that directory listing with
5.1 kernel always sends an extra READDIR request after a final reply was
received (values follows = No, EOF = Yes). I see this with v3 and v4.1.

A similar observation was reported by Armin Zentai:

https://www.spinics.net/lists/linux-nfs/msg73328.html

This behavior was introduced with commit be4c2d4723a4.

Regards,
   Tigran.
------=_Part_11538200_1789860588.1560258232349
Content-Type: application/vnd.tcpdump.pcap; name=readdir-5.1.pcap
Content-Disposition: attachment; filename=readdir-5.1.pcap
Content-Transfer-Encoding: base64

1MOyoQIABAAAAAAAAAAAAAAABAABAAAAmmz/XNvMDgAGAQAABgEAAAAADJ/wuVwmCnhIZggARQAA
+ERCQABABnUFg6m51YOpv5AD2wgBw00jgZXsoDKAGAH1gaMAAAEBCArUMQm37useLIAAAMBmdjra
AAAAAAAAAAIAAYajAAAABAAAAAEAAAABAAAAHAAAAAAAAAADYW5pAAAAAAAAAAAAAAAAAQAAAAAA
AAAAAAAAAAAAAAAAAAABAAAAAwAAADVc/2yXAAAAAgAAAAAAAAABAAAADQAAAAAAAAAAAAAAAAAA
ABYAAAAbAcr/7gAAAAAAAAAAAQ0AAAgAAAAAAAAAAQEwAAAAABoAAAAAAAAAAAAAAAAAAAAAAAA/
6gAA/6gAAAACABgJGgCwojqabP9cdPcOAIoBAACKAQAAXCYKeEhmaL2r14RBCABFAAF8hCVAAD4G
Np6Dqb+Qg6m51QgBA9uV7KAyw00kRYAYAFjIzQAAAQEICu7rHjfUMQm3gAABRGZ2OtoAAAABAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwAAADUAAAAAXP9slwAAAAIAAAAAAAAAAQAAAA0AAAAA
AAAADwAAAA8AAAAAAAAAFgAAAAAAAAAaAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAGAAAAB2V4cG9y
dHMAAAAAAgAYARoAsKI6AAAArAAAAAIAAAAAAAAAAQAAAAAAAAIAAAAAAAAAABEAAAAAAAAAEQAA
ABsByv/uAAAAAAAAAAABDQAACAAAAAAAAAADATAAAAAAAAAAAAMAAAHtAAAAAwAAAAEwAAAAAAAA
DXJvb3RAZGVzeS5hZnMAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAFus2zIUkEhAAAAAAFus2zUslZMA
AAAAAFus2zUslZMAAAAAAAAAAAMAAAAAAAAAAZps/1xw+A4ABgEAAAYBAAAAAAyf8LlcJgp4SGYI
AEUAAPhEREAAQAZ1A4OpudWDqb+QA9sIAcNNJEWV7KF6gBgB9YGjAAABAQgK1DEJwu7rHjeAAADA
Z3Y62gAAAAAAAAACAAGGowAAAAQAAAABAAAAAQAAABwAAAAAAAAAA2FuaQAAAAAAAAAAAAAAAAEA
AAAAAAAAAAAAAAAAAAAAAAAAAQAAAAMAAAA1XP9slwAAAAIAAAAAAAAAAQAAAA4AAAAAAAAAAAAA
AAAAAAAWAAAAGwHK/+4AAAAAAAAAAAENAAAIAAAAAAAAAAEBMAAAAAAaAAAAAAAAAAYAAAAAAAAA
AAAAQAAAAQAAAAAAAgAYCRoAsKI6mmz/XIT9DgC2AAAAtgAAAFwmCnhIZmi9q9eEQQgARQAAqIQm
QAA+Bjdxg6m/kIOpudUIAQPbleyhesNNJQmAGABb8YkAAAEBCAru6x451DEJwoAAAHBndjraAAAA
AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAA1AAAAAFz/bJcAAAACAAAAAAAAAAEAAAAO
AAAAAAAAAA8AAAAPAAAAAAAAABYAAAAAAAAAGgAAAAAAAAAAAAAAAAAAAAAAAAAB
------=_Part_11538200_1789860588.1560258232349--
