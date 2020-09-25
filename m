Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC082278B2F
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgIYOrb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:47:31 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:63493 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgIYOrb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:47:31 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 10:47:30 EDT
IronPort-SDR: gcPfA2ScSLwApd+a6y3fLTbV69VayoUuDYwFmi+wZZir4gc97YM830mUmsKPVCsDom1BsirYIx
 qUFH42/UhRYjpnm/77QfQk7/rxSwKM1/zEbBeJCSL70bMW9qJcOaFcsy2ylsyKfVd7KFcKaTte
 RcvjWiJF4S/Rep0aSvj5Yx0FlAHOqO8aru+9rKVXU8dnMGYAMNT7FVHlnrAZtxS+0o8R5oGwE5
 HeDVO5ZtHmL2sSLqfqstDDMDfXtKWOBQyvqajmf/i5cM8qy4c/eGs0YOp0L00/QSf8Oywaz0Oe
 xaE=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 245161071
X-IPAS-Result: =?us-ascii?q?A2EOCgArAG5fh6o3L2hfgQmBUYFQUXeBNAqEMoNHAQGFO?=
 =?us-ascii?q?YgXgTCXdIJTAxg9AgkBAQEBAQEBAQEHAhMLDwIEAQEChQCBeyU4EwIDAQEBA?=
 =?us-ascii?q?wIDAQEBAQYBAQEBAQEFBAICEAEBAYV5OQxDFgGCekk6AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINVCtWEQ8BBQgBATgYHAImAjQfG?=
 =?us-ascii?q?QgBAR6DBAGCSwMuAQ6bR44dAYEoPgIjAT8BAQuBBSmJV4EygwEBAQWBR0FDg?=
 =?us-ascii?q?mwYQQkNgTkDBgkBgQQqAYJxileBQT+BEScPgiWDTwEDgUVlgkqCYJANCgcui?=
 =?us-ascii?q?36BEphcgQmCcYh7hlWKewUHAx+SG451iF+VDpUgAgQCBAUCDgEBBYFrgXszG?=
 =?us-ascii?q?ggdE4MkUBcCDYEZjRIOCYNOinRWNwIGAQkBAQMJfIkhglIEgTEBMV8BAQ?=
IronPort-PHdr: =?us-ascii?q?9a23=3AaHbraxY55A2CtQ1Zax1dzUz/LSx94ef9IxIV55?=
 =?us-ascii?q?w7irlHbqWk+dH4MVfC4el21QSVD5vU5ugCiOfMta3kH2sa7sXJvHMDdclKUB?=
 =?us-ascii?q?kIwYUTkhc7CcGIQUv8MLbxbiM8EcgDMT0t/3yyPUVPXsqrYVrUry6s4jMIXB?=
 =?us-ascii?q?byLwx4IqLyAIGBx8iy3vq5rpvUZQgAjTGhYLR0eROxqwi01IEWjIJuJ7x3xA?=
 =?us-ascii?q?HOpy5NcvhWg350KEKahFDx6trj8Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,302,1596517200"; 
   d="scan'208";a="245161071"
X-Utexas-Seen-Outbound: true
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk1lGEaGsspCmvWjsYq8jIxf8hR6H4pmJGzwGGioorgHRtcJ4Gh+hONovKvuqbE8dZguOcEiWDTBvgRk6CQayu5A0m3qxpBP5b5VXTZDHrMmoG3KfIl3nyWI+VMOxppE0Y41dgF8uSrEO4smtme8taeyVQnqFfSBEuFN48AgBZNNaZykrINC0Ztw0hwuK/0PRpTQalbe8SY6hHGF7GY6jBOdfq0ukBq7SnZY/oApOnP4VDR57cQ3uN6lIfDM1nhXPVMlGL44IMYD1H6bBdHU/BEksQ5xAgafxJSBW/7yRdB9oZdXXNWFfm8j6Iv4bQBgapSa/so8nph7f45rPQweIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv/51gTb4WPWxIDeA9pXGI8WIZpNoRClAjrAbF6pgaA=;
 b=M/FJQQgjSDGqUfevgUrNPIydrkys6sov8aOWQ1m70bVBlF2zDWaaeKyWGw+IS239p2RXenfMSMoYYr4RbHe8PebT5c17L0C0NYJ0kPXEu9HmRm+mR/+AqaHuMNO6V9yhkdZnTfQsTkL1ZjLjOJYpQyY+o1BgyujcXEchho+MswoUS/XBb2tJoUD6BeqgcnKMPJBLpJco13lSY9yk+kAbX/cgl/8t8AmM2D9GM5UcfUZCfOfeIZXIPbNjAlvFrzV7Gb+jIVrD7Y7cUmCXFqZEnzpnB+9BI8ylqVSa2L5Flnnv7n1UD0+Hyg8f8LVTZryBOTXWBUcJChmiRSdLAeiqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv/51gTb4WPWxIDeA9pXGI8WIZpNoRClAjrAbF6pgaA=;
 b=Krx9WecZ9/0OvLwq9l7ednaODxppKvvIfkpc2HHvFPD8guZIRfLVbqUAHg5mFiHTRs4Jmn2gqMF6CMiWU5eLPwCTye96gPR+pSrkAxHKA9BZaBjzK5SlMikqntn36VX+Clr7exTfW2/OU+2ggULj/qtRQJJCluXrkQoL+KLGkZ0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4102.namprd06.prod.outlook.com (2603:10b6:a02:82::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Fri, 25 Sep
 2020 14:40:19 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3391.026; Fri, 25 Sep 2020
 14:40:18 +0000
To:     linux-nfs@vger.kernel.org
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Subject: rpcbind redux
Message-ID: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
Date:   Fri, 25 Sep 2020 09:40:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:3:ae::22) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by DM5PR15CA0060.namprd15.prod.outlook.com (2603:10b6:3:ae::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 14:40:18 +0000
X-Originating-IP: [67.198.113.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9408f9f2-30de-4328-8b6d-08d86160ec88
X-MS-TrafficTypeDiagnostic: BYAPR06MB4102:
X-Microsoft-Antispam-PRVS: <BYAPR06MB41026EFEB7FC2F1993F70F7483360@BYAPR06MB4102.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2YP6LfhbFQm1vfWZ2k2fLt8Ti8n3r+qvjHJmQB67wlXe1vovyZI1a+aIkeC95IuNQSo9Bxb3HUVwLzEDGmiaWyox4DdOusANXfo8tEqjKdmMmsV/CGxwOyda67qS0XTa6r8YvPCh1VYBHi8bF1Sf9IgOwX7567AwCbhqaAWxhXWL7jvHGlbAdLelkG3lLj4gfQ7K+QRzKUgVQoxn1emdZvCchBtNpsfILU0xz5syip5mdEc4Z3Xdzsoz7do5nolvWWqbOWvkC9xHbzj1de2S7yRpre/l14E63c2zAfxIhKxceMxnqdjbFmSzv/6+1z9HM9DrmbvDFayiku2OomsgHh7Cu1/yiXFgQjU7xdsyBs9UJaUTtvKVjAYaASVO73O3j4cFqrgdLp2Kysbwkh0Y/VIHzyxtiWPBMx0HCqBvi2fLVumw2bqKX7qfW3ujTfSzcLPPUud09yAbnl8lPcQDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(2906002)(966005)(66556008)(66476007)(5660300002)(75432002)(8676002)(66946007)(3480700007)(8936002)(16576012)(316002)(31696002)(52116002)(186003)(6916009)(26005)(786003)(16526019)(478600001)(31686004)(86362001)(2616005)(6486002)(956004)(66574015)(83380400001)(7116003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tZSLzvFnYikBJwhzNxGJ44f3ymDWjDkLLBOidJMW7WrlACa13bCfFQcg0+EBoApsbIVzgjfOzaDbUZkOVRgEq+hqjmE4ejLmYbGkLk58aeQVvFaSCczPdlc8jD8AXuSsjXxqGrzdFBpLWITirhQNc0DI2P07tdYvIfefUzAgfODz9vdV4cRPvxKhr45mSpyceW+Dh0VH2bXPC679SeKoVCm5Zx5B/ZLmojt/+MTmrnOMCQEC5d6awyhnbD9Hg9A/9FCB+EmfA4b1WrTSDcJ4cQOqYqW3K6hP5NjKilOwYsLTSweUCOFQ/WX4XiCPa/6+b6ygBBdrhCIpfuqX+IXsUBQqskMYcbwAxmovaha1FpKG8cHBSgpSTn6/AzZ+bfaFCmEMuIGyqmnoSNEbrENgibg4nApA5T4K5ukZ2zbtUwrbhRm/UQF2Nv+L27dB4GXo0DO8fMI4KXsfPdKBgMAsVy92K1TsJCs1uD6l4LfHfUy9BVl5qf+pVD9m3124mSMg+Db7i0QtNHCAvMQfkuiLELStqL2/OW49ulLMS+Y7WxCprIok+KA1zF2nDqvxKrT1GKVfoQmsfzm+l7ybOPrBB1WAenkXRSqYKlZYry15h3Wc/I02ZxRtH+XAAEfeaoJ9SzJ9+HuVwGrW5gZiVheEHQ==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9408f9f2-30de-4328-8b6d-08d86160ec88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:40:18.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kH/RdhY3Bs8oN++VXJXxoSSSGqbnkf8Nyng5+hBQLaV/IZ3+hM0I9U3jjN6+uyZ6Xt1fVuoy0yuKQDOFq3m6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My University information security office does not like rpcbind and will 
automatically quarantine any system for which they detect a portmapper 
running on an exposed port.

Since I exclusively use NFSv4 I was happy to "learn" that NFSv4 doesn't 
require rpcbind any more.  For example, here's what it says in the 
current RHEL documentation:

"NFS version 4 (NFSv4) works through firewalls and on the Internet, no 
longer requires an rpcbind service, supports Access Control Lists 
(ACLs), and utilizes stateful operations."

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/exporting-nfs-shares_managing-file-systems#introduction-to-nfs_exporting-nfs-shares

I'm using Ubuntu 20.04 rather than RHEL, but the nfs-server service 
absolutely will not start if it can't launch rpcbind as a precursor:

-----------------------------
root@helios:~# systemctl stop rpcbind
Warning: Stopping rpcbind.service, but it can still be activated by:
   rpcbind.socket
root@helios:~# systemctl mask rpcbind
Created symlink /etc/systemd/system/rpcbind.service → /dev/null.

root@helios:~# systemctl restart nfs-server
Job for nfs-server.service canceled.
root@helios:~# systemctl status nfs-server
● nfs-server.service - NFS server and services
      Loaded: loaded (/lib/systemd/system/nfs-server.service; enabled; 
vendor preset: enabled)
     Drop-In: /run/systemd/generator/nfs-server.service.d
              └─order-with-mounts.conf
      Active: failed (Result: exit-code) since Fri 2020-09-25 14:21:46 
UTC; 10s ago
     Process: 3923 ExecStartPre=/usr/sbin/exportfs -r (code=exited, 
status=0/SUCCESS)
     Process: 3925 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS 
(code=exited, status=1/FAILURE)
     Process: 3931 ExecStopPost=/usr/sbin/exportfs -au (code=exited, 
status=0/SUCCESS)
     Process: 3932 ExecStopPost=/usr/sbin/exportfs -f (code=exited, 
status=0/SUCCESS)
    Main PID: 3925 (code=exited, status=1/FAILURE)

Sep 25 14:21:46 helios systemd[1]: Starting NFS server and services...
Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: writing fd to kernel 
failed: errno 111 (Connection refused)
Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: unable to set any 
sockets for nfsd
Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Main process 
exited, code=exited, status=1/FAILURE
Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Failed with 
result 'exit-code'.
Sep 25 14:21:46 helios systemd[1]: Stopped NFS server and services.
-----------------------------

So, now I'm confused.  Does NFSv4 need rpcbind to be running, does it 
just need it when it launches, or something else?  I made a local copy 
of the systemd service file and edited out the rpcbind dependency, so 
it's not that.

