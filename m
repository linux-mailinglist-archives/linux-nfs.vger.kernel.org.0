Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771E78A849
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 22:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHLUUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Aug 2019 16:20:52 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:51216 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727527AbfHLUUv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Aug 2019 16:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com;
        s=ml20180701; t=1565641251; i=@ford.com;
        bh=RTQbyQrwNstqr/uS3AIhUhSrVUTIJ1lL3lx6EqnZUqI=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=OeVE78SC5vYyTg1awr2VYZzujbm6dIA1goP1zNOxmSFxIyrX7AAGH2nGO2tZ7ZtnS
         4y0WpMO/QV3x5mj3USm0SED11jIujjTroi7wjyZqeqSuj3jd+469+7ReWQDwwndQ5I
         0DzIe+ZTvhvj+Y9PVuQ5maxsp3oZnKGE+yVexT2LTtLuMPbPCHAmF/eGU85hcl9zmN
         UH3GGQMkY7d4YvoPoJZDFexqvg44YEXx8xYRalvH/SgaOXKP19WBUq3eo1dh0R3OSw
         gkoOqtFDQitm9p7p0epdw8CntYPSlz13hfk/8LDDJ2+bqDR05RMPj9FMXUx1Wp0TWC
         oXjKJiTGIb9CQ==
Received: from [67.219.246.97] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id EE/C1-10607-32AC15D5; Mon, 12 Aug 2019 20:20:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleJIrShJLcpLzFFi42LpYBJi1lU6FRh
  r8PSSrsWFA6dZHRg9Pm+SC2CMYs3MS8qvSGDN+HL3ClPBZd6KiSfuMTcwNnN3MXJxCAmcYpRY
  8/wHE4TzkVHiY/c7KOcIo8SNHw1ADicHm4CWRPv/o6wgtoiAtcSZ5insILawgJzEsbszGCHiy
  hI3Zs2FqtGT2Dz9O5jNIqAqsWnLSxYQm1fAXGLhrFYwm1FATOL7qTVg85kFxCVuPZkPZksICE
  osmr2HGcIWk/i36yEbhC0v8ejvXBaIeh2JBbs/sUHY2hLLFr5mhpgvKHFy5hMWiHpJiYMrbrB
  MYBSehWTFLCTts5C0z0LSvoCRZRWjWVJRZnpGSW5iZo6uoYGBrqGhka6hrpGpoV5ilW6SXmmx
  bmpicYkukFterFdcmZuck6KXl1qyiREYHSkFjL93MN4/8lrvEKMkB5OSKG9RbGCsEF9SfkplR
  mJxRnxRaU5q8SFGGQ4OJQle/5NAOcGi1PTUirTMHGCkwqQlOHiURHjVQdK8xQWJucWZ6RCpU4
  zGHBNezl3EzHHw6LxFzEIsefl5qVLivEdPAJUKgJRmlObBDYIlkEuMslLCvIwMDAxCPAWpRbm
  ZJajyrxjFORiVhHlbjgNN4cnMK4Hb9wroFCagU7if+IKcUpKIkJJqYNrVX/7ltOxztdNphb39
  Ek0sexsjZZkvrJkYxz7tvu3h9ZsX7V45mUtK/kbIocc/tD39RdKuvTW5t1FCQ3/TJ4ulvInyW
  p6fn6nyn828FjsvQPKm1YL4Vdl/hBLMvh2XXlL8d8L91ZNDNJX/FpmteLKdwTXscb/e908Pyy
  4/UX6zYva5CvMLOsFbLr03NrvB+SRaOv7N8prJ3/Sfi0TUXOh4mHZe/dZ5n9hGZZP2I5t1Nfl
  6zuzomXte5PfF7byxubKXZGYFvvf1Wcq+LZntpYKK9ZzLizlXWQp17Nj0S1ND977WG67HSXMX
  iqd/+9c+Z4599+q92yq6uWS/H7gSt2iq2rcLUVtcd12aGfeYa2WYEktxRqKhFnNRcSIAglAir
  psDAAA=
X-Env-Sender: echan17@ford.com
X-Msg-Ref: server-9.tower-381.messagelabs.com!1565641250!398251!1
X-Originating-IP: [136.2.18.3]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2045 invoked from network); 12 Aug 2019 20:20:50 -0000
Received: from chipo1.azell.com (HELO chipo1.azell.com) (136.2.18.3)
  by server-9.tower-381.messagelabs.com with ECDHE-RSA-AES128-GCM-SHA256 encrypted SMTP; 12 Aug 2019 20:20:50 -0000
Received: from fcis870a.md4.ford.com (EHLO nafcmb04.EXCHANGE.FORD.COM) ([19.107.2.39])
        by chipo1.azell.com (MOS 4.4.8-GA FastPath queued)
        with ESMTP id AXM78125;
        Mon, 12 Aug 2019 20:20:50 +0000 (GMT)
Received: from naecmb02.exchange.ford.com (19.106.119.7) by
 nafcmb04.EXCHANGE.FORD.COM (19.107.19.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 16:20:49 -0400
Received: from naecmb02.exchange.ford.com ([fe80::f072:e8f6:ad65:c6bb]) by
 NAECMB02.exchange.ford.com ([fe80::f072:e8f6:ad65:c6bb%9]) with mapi id
 15.01.1713.004; Mon, 12 Aug 2019 16:20:49 -0400
From:   "Chan, Ewen (E.)" <echan17@ford.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: How do I set up pNFS?
Thread-Topic: How do I set up pNFS?
Thread-Index: AdVRS22/pzmSQBOWSfehiCyoiRhL3Q==
Date:   Mon, 12 Aug 2019 20:20:49 +0000
Message-ID: <b7585075f56e4e7d9788a1be33251680@ford.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [19.37.76.52]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To Whom It May Concern:

Here is what I am looking to do:

I have a small cluster consisting of four dual socket Xeon nodes and each n=
ode has 128 GB of RAM.

What I want to do is create a 64 GB tmpfs mount point on all four nodes and=
 then export it using pNFS (NFS either version 4.1 or 4.2) so that all four=
 nodes would "see" a 256 GB tmpfs mount point (4*64 GB) that is then shared=
 acrossed all four nodes.

(I also have an Mellanox ConnectX-4 dual port 100 Gbps 4x EDR Infiniband ad=
apter, so bandwidth shouldn't be an issue for me).

In my /etc/exports, I've already added proto=3Drdma, port=3D20049 to the mo=
unt point export options.

In doing some of my research on here: http://wiki.linux-nfs.org/wiki/index.=
php/Main_Page, it gives the example that the server appears to be just a si=
ngle server and that pNFS is just for multiple clients to access the same N=
FS export mount point rather than having multiple servers contribute its ow=
n portion of the space to the shared, scalable NFS mount point.

If I want to do something like this, how would I create it such that the ex=
ported mount point and the client mount point would know that it is a distr=
ibuted, shared pNFS pool/mount point?

i.e. would all four nodes be both pNFS (NFS v4.1 or v4.2) server AND client=
, such that each node will have a line in /etc/exports and it would also ha=
ve the corresponding line to mount it in /etc/fstab?

Will having all four nodes add towards the pNFS mount point or will pNFS ge=
t confused because there are four NFS servers trying to be the NFS server s=
imultaneously?

I hope that my question makes sense.

Your help in this matter is greatly appreciated.

Thank you.

Ewen Chan
CX482/483 FE Engineer
Ford Motor Company

