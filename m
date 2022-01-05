Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69063485608
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiAEPkZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:40:25 -0500
Received: from mail-tycjpn01on2114.outbound.protection.outlook.com ([40.107.114.114]:1040
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241592AbiAEPkZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 10:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIgopLLr6Q6zvhsh1BDcBhGXaHIIgsYlZPjRHK0sOpY=;
 b=cnFNz9C98RVuBtrt92gtUy6Zhi/1rIC8Y3J0MUfXapRVNIpqnZYhJ1dCOm9bgQ7udY7//HX5rum5esS1Fm59qcLfjOW6x4+nb0XscVlI3Aa+IHSdWSDt+rRHyohZKMfZDC0Db9uqnA+VGLvae+rkK+NNS5/KEmk0T5F+T/+KqYE=
Received: from TY2PR02CA0065.apcprd02.prod.outlook.com (2603:1096:404:e2::29)
 by TYCPR01MB7554.jpnprd01.prod.outlook.com (2603:1096:400:f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 15:40:23 +0000
Received: from TYCJPN01FT010.eop-JPN01.prod.protection.outlook.com
 (2603:1096:404:e2:cafe::1d) by TY2PR02CA0065.outlook.office365.com
 (2603:1096:404:e2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 15:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 TYCJPN01FT010.mail.protection.outlook.com (10.118.160.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14 via Frontend Transport; Wed, 5 Jan 2022 15:40:22 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.58) by
 AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 5 Jan 2022 15:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyX86h2hBkD7GnGS3FVMUOln+xcsNDcuUvHjub++V7YKwjZATH2oXRZzhzTwuU1GCg1w5jT6tbqFdC+DKMSP6UFd2wtQmdLU8zlsnpX3pmUAyfui8Crv6bgXp/i2xYxxj37DNw8FQnp+inuVTYmzzKOH8G0uGtuziJn/FnvUMEU9icA582qvLiMrCbds9W6Wmww/skwaIzlQjVX9uTUCedVBMHSr6ALfEso/ZxoMo0JS8Dm7/FnWneXgoY40Jug+pADvLAbEw3rXIumZ0toUkt4NsUe2GzNLKS2VVwhojly5UyWDZj7o+WqIATYtA+CRsxeDpwO86vTZHpFz5gjzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIgopLLr6Q6zvhsh1BDcBhGXaHIIgsYlZPjRHK0sOpY=;
 b=TC47oeHKlAKZCA7CVif10Paddtmy/1D+oIHQClwb6yQoPFsiB7LWodBB7ZTBJwZOG417JEr6yUXhbqM47JBoAa9mrK2k0DVjoeRSgnzmHIJa3s8tOIyBHgV+x2cwsa/tKf1GY+0CwzxMXg507aMKzvno0hAsFANvQZuwx/8eJanM7QPYi6cEwPeUsI7fGotMXRtUAuvtd8OrA1dYKmnHHBukO+5RuldpStmuyLul/nU9pzc8XCFOzf5J2YoKymhLkuEColfz6IfJudLCLE0CzxXGLypFlMDo6R4OPPC2AwsYy0+GUSrdEG3f4d9PfoXbN7lsT+FO7lamivR2MJrJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIgopLLr6Q6zvhsh1BDcBhGXaHIIgsYlZPjRHK0sOpY=;
 b=xerfJRPKWFpjb6Aor+cDCJBfIXpre0SMEfhpN6KwiyQXbIZphKo4ZswQdro9O+aQN6lBumJVMxD5k/YQGeGxULGlojZIV10/8Y5X1PMGdcTls9n9G9ETYPZXdmzCouAEji388Uqh2lqVJO3w0RV6BWZrRzMb1Cw4564UBPAWyiA=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DB9PR10MB5137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 15:40:19 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 15:40:19 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHYAOOnWznuBWlA7k+POKyqIasZNKxRxaOAgALAoRCAAASbAIAABaVA
Date:   Wed, 5 Jan 2022 15:40:19 +0000
Message-ID: <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
 <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
In-Reply-To: <20220105151008.GB24685@fieldses.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: 67ce4975-8f33-4c59-9719-08d9d061afe4
x-ms-traffictypediagnostic: DB9PR10MB5137:EE_|TYCJPN01FT010:EE_|TYCPR01MB7554:EE_
X-Microsoft-Antispam-PRVS: <TYCPR01MB7554273AE512A496F2792E3CD94B9@TYCPR01MB7554.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: y+EMifAVzZ+TWMGe0xGXdagfk3yBEYkOGIbeR5OlRZuC/Nol0mjnxbze55vsfmXk4deW+x79+PW+OxNJWk7I82/9ZhVmUNERlZqq2ayEEU12Dtcnf9K1uv9vPrrKj34T6D2ZnES5Vlo5oZ55zkZqSs/iT213FL3MUEM1R613XcHIo6/83l6xJj3u3V2Xixbc7ddhqv2lB4rCDhbXXyTRFavgHJp7FZMktIt7OIb9kWQZ0KQuNzcuyCTlumNbnr8S4Cm8X4JdJhxu4i9nR9/m9RUuObFFkrCmCOwHmAxNKDJ/vE5lMNw207tKi6K5XbaBXn9YhtZWIeuEkb17/LnbYd4WmVFSU9B7m+uKU8VueAwhd6tIwVcYUpDDbp5efvibcCb7x2p3kVDIkTLmtvgYHAV+PuDInIwkhf9idcq3wUHTLxHNcCrTKwJo3bdllMtq+P679/ENgr3l+Hk9Rtw2bRSPQpg+UyazxRaHKQWbujWOuud2ihMtb7IgSyrSM8oZrxFHSOnACSw/NsgeilnLbDPrdUKDUyOBQz8FTPLtHWvvIZDjVIfRfFOGdRNCIbTkWtm6Y58k4NdEmspC+v/TPq348f0ms/3bBclbmLCCIJw8MT1Ln9RMt1qySpWEFhsaOs0RkVa0adnKiyBXizEFvWvxCnUyLw8J5GXeX/JN9HpK0eCN2uaun39MhuO+JFQRtMYj5p6uZxMQ+ThjOM5rlA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(76116006)(66446008)(8936002)(66476007)(9686003)(66556008)(52536014)(64756008)(7696005)(8676002)(2906002)(122000001)(38100700002)(5660300002)(186003)(55016003)(71200400001)(86362001)(38070700005)(110136005)(508600001)(4744005)(55236004)(6506007)(83380400001)(33656002)(26005)(54906003)(316002)(4326008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5137
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: TYCJPN01FT010.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e802368b-723a-4f08-5402-08d9d061adce
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr,ExtFwd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDJbhNKaGpPuWA7XFhQP0I/gubfa0XoDrUkzGWXbZTC4nGAip9b7lwkjjyiihNR1ON8PDs7VrRoqR7vv5hpbYlChb9Eb/we0FsgJtZ/jTjBwGVSKp0G2hMBLxR6dYCFILT8DCRo7oWYXwESLubr1pJ1tt++1mSlWu4jukSLf6QRMD+K46LHLumKnfoNTEeAPqorVspo0hOOh8JB9ArQr+I/ivtm8lvdrdMxYbm9aZNKmutUY8B3K/JF2HaYiVYmSuOfQydE66dp0sJ5uXHF+dOdCyfwZ5++rTWs2fcZ1NzWUmhFEJGkYUMY6o41v3qdrwkshP33/XYKtCZyeUJs1+rihocJk4Qcn/O8hz+3NtxGJri+I8JEnhRSqY4YI89QLrNKqyhPI0jeNp8VC7Ni/8nafULf0v72bJO4bT2zQG78enajgX/sMN770iJlZIjA77LRdggTtJDiXNgjorLSFchloLvDJ2xD9J7lSYIsa4fCnchBQ842WLMF2aqgBqrEcLZn1Wnus4JrsPH+dIImpD3hvfVkVPCbaIpk7Wp8V+v9sASn0KlsNFTUT+LyaC2Vc6HeRnb1eHTtHAuSl77TnBUtUOp1AFLo0c3XZGP87Ckaq1EvvUitS2tAJePIwM9OUNKxZu4rOlcd2R5h0D2IWE9Pvg80x8sRnmsdia4uFIjyDa1Q6khuF5/PjjOyGnr4yoP7sUo0wIwd20lMV2zFj2iwZit4mXzIunB6SXax+/U4hCXE/2DxSMmZKCxhlDC5ZwU9+hHUv1MzlLLgjzeJurjR0tavgVe9gRJxOFfJptT8=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(33656002)(8676002)(5660300002)(86362001)(70586007)(4326008)(4744005)(336012)(54906003)(186003)(36906005)(110136005)(9686003)(26005)(316002)(8936002)(508600001)(36860700001)(2906002)(356005)(55016003)(52536014)(70206006)(81166007)(47076005)(7696005)(82310400004)(40460700001)(83380400001)(6506007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 15:40:22.6034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ce4975-8f33-4c59-9719-08d9d061afe4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: TYCJPN01FT010.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7554
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


>> - AFAIK support for RFC8276 in NFS (only version 4.2) server is since ke=
rnel 5.9, right? NFS client supports these as well?
>> - The patches below implements the feature in both, nfs client AND serve=
r, right?

> Client only.

Right, but then it will be only useful if we use non-linux based NFS server=
 right?

I mean simply:
1. $ stat /tmp/foo.txt   --> shows birth date
2. # exportfs \*/tmp
3. # mount 127.0.0.1:/tmp /mnt
4. $ stat /mnt/foo.txt   --> no birth date shown
Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.
