Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3D486222
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiAFJbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 04:31:24 -0500
Received: from mail-tycjpn01on2134.outbound.protection.outlook.com ([40.107.114.134]:46756
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237434AbiAFJbV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jan 2022 04:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCSPvrWodM/nOVNzTOQ4AkW7Ii8FrXuul9GzCOgsRMY=;
 b=ld0150ICft82g4D2ktn1JAGkJVYGvW1GzWWzIgzF5Cav9BBewuDDblaqoSltuxHQLNCBHNEuIb6EnX/Jc/xVfUnTiT7C2zND0H2ArK01NLoQVJ1A69JOU2FprGbm03S/wSJZGVsF5/0ZNhhlN1qFF/QMVzdzXjtG9Iq++e7s5c0=
Received: from TY2PR02CA0018.apcprd02.prod.outlook.com (2603:1096:404:56::30)
 by TYWPR01MB8541.jpnprd01.prod.outlook.com (2603:1096:400:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 09:31:19 +0000
Received: from TYCJPN01FT015.eop-JPN01.prod.protection.outlook.com
 (2603:1096:404:56:cafe::8d) by TY2PR02CA0018.outlook.office365.com
 (2603:1096:404:56::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 09:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 TYCJPN01FT015.mail.protection.outlook.com (10.118.160.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.10 via Frontend Transport; Thu, 6 Jan 2022 09:31:18 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.175)
 by AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Thu, 6 Jan 2022 09:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEBwKucuHvdZnIV1sU1c+b9ar5Gx+az7Mjil9WmDtmHZ9OoX9yQLeuq+ZaQxG7DNnhtvcoQiAAmJxr4U8LizutUP2d30rzlUiJrYypkqd2/c9XFp4YV6RwDd7MJnzijAT1PY73CGTQerM6HiwwtZBDI3XPmFzbyjn6tdV2BcuSLvqdJKCKYtFNtax3Kq7cmXDZm6yVYUkmDwW7X/nK1iHTsNM819zsDF1Y4/W2y58wMk2oZ9AJ58G0vVmytej6TngdvqBOY5HxN5gmwm0F+uHI2a1oJpfGHkFWwLTgqDtke9RspjEEObsK9RshXS7TejS+ctQOQOPhn0kYoTFj6aOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCSPvrWodM/nOVNzTOQ4AkW7Ii8FrXuul9GzCOgsRMY=;
 b=M7pENjNmJoMCaWaqydrN6Ps8kKb0QNtE6MZpzRNboH4C1G4QTM3Dg/TY2yZJ9ZycZoLwsSBLkOIMhvoLxH4OeITsrqB6geTUlpXUGiXcWIApXybCARZS0pqfx3RsIZoNnYNHbPjGa0ub421vQ1Lz94xZQXpyUMQSkYOymMqXgVL3pA9L3CjJdqjkH0jKDzV82yw6fhDGYvmxyscW7y0EG45zqaWDBJRC/0f+/MK3uSZ4LqRMhqlCFzY3s+oKscBH+clOw9DQqbk4ciCjV1eUADSHuybkaYvWgFqQ3rMGQxWhlKNe4EGlHG5jqD9FF/KnAy+k3q8Isn/wOHcDH83TpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCSPvrWodM/nOVNzTOQ4AkW7Ii8FrXuul9GzCOgsRMY=;
 b=V008vHgf1nws/W2z4T9KrTxg8NquCriSbJuzJ0XJ/duAkRZlvlQvHZsSs39nddJt35Sz+JsJGc8PBJdIltFLTG+UmqrGuXbnkKp8Ao8kIVP22X2fUx0qPUsmMtAfXlE4QvjLNrNiSC7ERSLhGt2BT1AgNz6+Wl9Z0/PxDrWhp94=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DU2PR10MB5079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 09:31:15 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 09:31:15 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHYAOOnWznuBWlA7k+POKyqIasZNKxRxaOAgALAoRCAAASbAIAABaVAgAAG2oCAASYa0A==
Date:   Thu, 6 Jan 2022 09:31:15 +0000
Message-ID: <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
 <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
 <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105155451.GA25384@fieldses.org>
In-Reply-To: <20220105155451.GA25384@fieldses.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: 07cf1ba7-3202-4134-25fe-08d9d0f74b69
x-ms-traffictypediagnostic: DU2PR10MB5079:EE_|TYCJPN01FT015:EE_|TYWPR01MB8541:EE_
X-Microsoft-Antispam-PRVS: <TYWPR01MB85414C96A40BC17A479A1547D94C9@TYWPR01MB8541.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Htn67DFgxR/ngZWcCyQ6Sa9Kc0HH0i3mgFQAFFdh/4lo/oyN50I9802ZWuS3mMk9Dc5Cr1COgeTXbKsfZ1rOWR6O2X4QDxa6fP0mPbLfDr2Qze/tbjD6m2ZtV1pQEhn+GZppJaxKKWGrtJoRsvYSRbeoG3l2BYOwPjZgZoSyRRFFLuG+m0L91AmKy/wH0fJHTamYCABmdCg/G0vRurBW7HYni0GoAUq0DixQTzAM0PbEqKObg3vMnj86FAD11QnWQ7UOOpgMXh+yecgaKpJmWIryjfrG1v9nk82LYXgBGN0ORt8yM3mOOlaa70BhjzwttxGf/CoviWOOf226X2/Z3n0BFF8wv/J1HTKneW3SYUdyDKXMBWj/fsnYZxKfwyWI98HsVMKINgI+h9O6qATueLCQkx71U8NlFqqIkiZTUNkBhrI7r9zPeN2L+U4PSCRgnACQfVhrzeudAMxK/dNWOJ+7y7zM3EE7d5mnpIOljOk3UqFQIofLuVWHdZ+3IMfsa3YWgkLDuKidA9DEEz72t5XNsawOLEuUnTSwX8oqiKrcACbvEedeH5ELEuwUObuigvjncRFLOoMZ5cu4j7qNvlRp482cs4uUbHqwqVGZbU/bAUEGlPseaD7F2q/6glS8ekD5Dk6kO88XI95XdpjouWXda5yUJd8nCHyy4wcmQH0NCrBqw75a9KA36LqoyXkXMIHI2lWgQjeKNIzBhQCpCg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66946007)(38100700002)(38070700005)(66556008)(110136005)(122000001)(66446008)(26005)(186003)(66476007)(7696005)(2906002)(4326008)(55016003)(5660300002)(66574015)(54906003)(86362001)(33656002)(83380400001)(52536014)(508600001)(53546011)(9686003)(8676002)(55236004)(6506007)(76116006)(316002)(8936002)(71200400001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5079
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: TYCJPN01FT015.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1df276b4-e6a5-4574-ebe6-08d9d0f7492d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr,ExtFwd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqwkghWkCvVDFqWdJBvCw1+Wx1OLKCXpuqXNVRkemwY8HiwoGiL7d0mlabaI3d6FWiovWSkcG0rDoK/bPv/91b2qvP3M4mNSJ9W1qM9NYltnamhl2dV1KSmDa2QjplFe8UxMQh7nDyP+vMdg+Dq6j96srSFOOdSpKZWt/VbiBzYVn0/ugvlorxBu9jZQt+PJNooxqhGGtVG5gkO1BRChVnOyv3wmj6NoQfLkgDHFxUcdGL3oKsMPWjdyCRuNPvRJaKog5n1MsYtw4D4k0XNTHVSve38pHVS7bHPofTQksmx3G7CEo2hONRFWIV7uTAjccfOg0u6VoQyj6fTkXGYCD26t0rJ5FqLJgAqaS+f4gQ+g34KrrhKZmosaY/1jprWboLG8by9uRYHMTWEtFKTvSTyP703LsHWw87i2T51sd2700U8PG/gNuKVZGOMlvGBom6M4WhRUnn3PRbQMOOtq2pMxQE5SycvhEdXI/822OJzYz0rHV9bhqVq1kEm8BNuGIfpRAy+ywc4LAbG/ntfzobDyrjkoQtShn9VzNpShHajty0nhDhKXpbAn9NYGpb5xnCyJJotUIWbRzlEmgdOj5DJOveJBKQfMszgr1n8RRiwaUtPNkE9Q6VfJDpA0Sn4ihax+KaKxRh+Qv04TMaHPETttSCk1/W9qslJP/Q2Yh/M5sDT0X88dbfwZGOUB71ziBovMeI76LWLU7Kri2TsmYJOX70E/RRSm5vRJmRx8msnVqoW5ezxhZ/qZfGeeEd7jerLdLR6+rjndS3v7N9fMhL/SQU3WHUV1fwOQ540ALkE=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(5660300002)(83380400001)(66574015)(356005)(54906003)(8676002)(336012)(8936002)(110136005)(4326008)(81166007)(7696005)(33656002)(26005)(2906002)(70206006)(36906005)(70586007)(6506007)(186003)(508600001)(82310400004)(53546011)(47076005)(55016003)(86362001)(9686003)(36860700001)(52536014)(40460700001)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 09:31:18.5161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cf1ba7-3202-4134-25fe-08d9d0f74b69
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: TYCJPN01FT015.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8541
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks like this should do I guess...

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a93a5db4fb0..be47e1dd6da5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3265,6 +3265,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct sv=
c_fh *fhp,
                p =3D xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
                *p++ =3D cpu_to_be32(stat.mtime.tv_nsec);
        }
+       /* support for btime here */
+        if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
+                p =3D xdr_reserve_space(xdr, 12);
+                if (!p)
+                        goto out_resource;
+                p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
+                *p++ =3D cpu_to_be32(stat.btime.tv_nsec);
+        }
        if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
                struct kstat parent_stat;
                u64 ino =3D stat.ino;



-----Original Message-----
From: bfields@fieldses.org <bfields@fieldses.org>
Sent: st=F8eda 5. ledna 2022 16:55
To: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>; trondmy@kernel.org; linux-nf=
s@vger.kernel.org; anna.schumaker@netapp.com
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes

On Wed, Jan 05, 2022 at 03:40:19PM +0000, Ondrej Valousek wrote:
>
> >> - AFAIK support for RFC8276 in NFS (only version 4.2) server is since =
kernel 5.9, right? NFS client supports these as well?
> >> - The patches below implements the feature in both, nfs client AND ser=
ver, right?
>
> > Client only.
>
> Right, but then it will be only useful if we use non-linux based NFS serv=
er right?
>
> I mean simply:
> 1. $ stat /tmp/foo.txt   --> shows birth date
> 2. # exportfs \*/tmp
> 3. # mount 127.0.0.1:/tmp /mnt
> 4. $ stat /mnt/foo.txt   --> no birth date shown

Right.

Fixing that's likely just a few lines of code added to fs/nfsd/nfs4xdr.c:nf=
sd4_encode_fattr().  Patches welcome.

--b.
Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.
