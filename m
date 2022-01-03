Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576CF483780
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiACTUz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 14:20:55 -0500
Received: from mail-tycjpn01on2097.outbound.protection.outlook.com ([40.107.114.97]:14821
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236090AbiACTUy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jan 2022 14:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2zKGIwg5XS/hQI0louDUTdF0iBLqTKwAJEaMBZ6QrM=;
 b=ILs/EGcKmCiXY8h6zOEt8z/sXwaGUTbJpaLRzRxnlK9LtuxdtUSIf41MHfj1QFyvXpiPBTE2LdnkRi/VN9fO2ni4VsSl0Q/7KxnA0b6eUAmMwAaQMY3txT2FGdEm9/qKy6FZ8pV18Bt8SFTSkuMNW8mSeay2n8FmrklPGAN5r+o=
Received: from OSAPR01CA0292.jpnprd01.prod.outlook.com (2603:1096:604:2c::16)
 by TYCPR01MB8641.jpnprd01.prod.outlook.com (2603:1096:400:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Mon, 3 Jan
 2022 19:20:52 +0000
Received: from OS0JPN01FT015.eop-JPN01.prod.protection.outlook.com
 (2603:1096:604:2c:cafe::61) by OSAPR01CA0292.outlook.office365.com
 (2603:1096:604:2c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Mon, 3 Jan 2022 19:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 OS0JPN01FT015.mail.protection.outlook.com (10.13.140.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 19:20:52 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (104.47.6.50) by
 AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Mon, 3 Jan 2022 19:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWl1LLEj4cWAC5jYZcQ1YD19TT8KvJ7cPJ20iOLupWbgMOs/Vv4UpzjPW/HgFV8Fnf8u086z8rIGLseltSmOEXTyhjJvfwKBpHhHfwzp0tRR+wSAz+m91fslZbGkLhKzQTfIvazD5Q8ANTYHTyix5mB4ZLSJk1QtEptY63rkwUAg6+OUjRtgK4Gx2MmE2jt/oT5Po9aPzn62pM+Yu7Ej8UuWQ6D7IQSn5+QJxPEdBwbqRd1bV2VjYsvYmZayRkctuY9q3pmpKIeYwP8OayIquQo+Dgg5OJ5jpWfevBcq4+22QdNsQfem2JGbMD+mK1RI83VIsyGlrQeatgpupx1OEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2zKGIwg5XS/hQI0louDUTdF0iBLqTKwAJEaMBZ6QrM=;
 b=OQUjx9GW7q9N4rR6vRuzDUJoCRkiF/Ve8/QQv8vouVl/U+b1j0TUdM6GZZFa3uAVhLkAE8TXGmg9D+I3AfUbe7hQk5EmIp55JRdc39/NKocXJQLjMcfAsj9PbVK5fDnGQ+jQMzWTDr0xW7thwRbD7o0k2zlxoIxb5iqHuD7eu8HlXGQbo9zUGlU4lV4qwYXa/sF3FDCiNpDc0PKGx8iZyDMZGJNl3X/tOeSwvNdyyt6XUOHbSnehIg24NQ7SYC14U6CoMllfb3gu0mON9UG339yD0nV1ThOfWsAE1jqqEaAMh8smBi1pngak1MdibUK6QmCE+hyBNwvGK3CU9tDtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2zKGIwg5XS/hQI0louDUTdF0iBLqTKwAJEaMBZ6QrM=;
 b=EvF19zNLEq0sQ2OCpfbjT708vsD3TeifK1rnDBsLbvOZOUvr1OOlGYjGwOBWB4Q8PzgBYwOuc71Yw1DGuMaCNKuVqB85rqe9ropug3077lLHPwbkIOjUDTJF4LxjsO2NgbeVD1agQAu+h8ovRBfY1RBi37Kf72lLm2FaGYZxPCE=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DB9PR10MB5306.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:338::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 19:20:47 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:20:47 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Transferring birth-time time stamp over NFS
Thread-Topic: Transferring birth-time time stamp over NFS
Thread-Index: AQHYANa75xQbwfWskEGifKhiULLDTg==
Date:   Mon, 3 Jan 2022 19:20:47 +0000
Message-ID: <DU2PR10MB50968B9A8A8C7EABE9E74C9DE1499@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: cs-CZ, en-US
Content-Language: cs-CZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8a759083-0824-5429-0376-a01370e9bfcf
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: fef3d717-f0ff-492c-0b12-08d9ceee2873
x-ms-traffictypediagnostic: DB9PR10MB5306:EE_|OS0JPN01FT015:EE_|TYCPR01MB8641:EE_
X-Microsoft-Antispam-PRVS: <TYCPR01MB86410ADBED3201C3A5F9D896D9499@TYCPR01MB8641.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pdtJ0RJ6I97xxIgb55i7jRvy2UGsX7Dqqqdwd8B5jPvbRbkLYVHfC/STcxWHQn6rwkblgJd7j1QFI0hCT8JI5MUO5/xizt6EbIv8O+lDCk5nfJO7UB+GXfXy6apg+3zin1kCVGA8MXePup/J1KFPoSqhZDt2sgfdSNLZe0GiiVV84cCzwOzENXLJqkiM+ok2KgaCOPd9Q4+HISnzAVPDw9DkkYflatX1tRDEneUdfliFjoK2nR5eqHWu8zeIr8359rsRK8sMKO6ihfVNnkb7fyCsLzkIohPfjNIJLqzGxdU7r6FSsSS39HlZVs/FSyFTirJmJ2fJI0YDYyomSy0H/udMrtvl6bndT/mFKDVufiu0Kij3KoIDgNkLu+8q9a8DfhUuyrxmjdDqRQKlLrSRPkAnfuVbikii7yQC0SR8N3+Fw/lrhMVQ9NCN4XGpX8NudAgu/PFVQwsK8rPr+VH7HE2uuXw4lis7dAiaGwSIKRSTd5WHfvL5kdrS6e6s6o5i3PHJDIrJZCbLC1VlLkxePEboI4Sq2//Mt8tFYbNx907seD87KF3vK/5nerKJDJsNdOHO80gbqTK9ky5amaxlEhQ6rwL/1ejJc6lAK7rbOGQxgVxBTqCmhP+s9d8EYOJedZseogdQ+0PEkGU5+oAS9OnsGSXTdtWpxxcBllnTlY7r2XfU4/6kt6sqWIPOYZcQve1px7yb7yUSFGJJtTkTwg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6506007)(7696005)(316002)(6916009)(8676002)(508600001)(33656002)(38070700005)(76116006)(55016003)(91956017)(52536014)(4744005)(8936002)(5660300002)(71200400001)(122000001)(38100700002)(83380400001)(9686003)(66556008)(66946007)(26005)(64756008)(66476007)(2906002)(86362001)(66446008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5306
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: OS0JPN01FT015.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8f056f4e-6805-4c28-6108-08d9ceee25a7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyAbjIOWU5PzFCjuZA//k5DSThpC6DJO7D4RCHxlIJPtZSAQDqbuEC5tb/LB/q/svZx40xk2ZUkKvg0QkALxEmBjzM/s3xvzSoMK0+Z6X1AklYh7i9A92YT0JyCTjQZTsq+NreAnxFBlmCkgQhrLS315Q+n2IiPthSiA33JuFjBsyBIh4U9cJHA0vuAvvsoe+Io7eSbOv+aZ/OCachQkIjnCpgeUzq5znlJqol4xVnl0/7lHUih1IU3UsLfeDlOAOgktDpgC0jTpVgovzBXOThA5PiBu490IjruGDlAktnh+TVCyOvFxxrPhQ4aFThrJsA1k2CqOB/YGbmt5uO/gyD0lUpZ1EzBdC7jV+bv4u5yEUnIIa7Wvjo8Ab9hcO//DmFDJgKsHVNsgxp845FIJk5TTPeXav9bzwmlmQyXnMqU4E8CNPkkMzntlwmGf2PD/v+mOA6nrjeA9dcSumfHYmRdjQyIQTczFYGMkoL9Zm1zM+1blQs5y4zLzakx1sF5X3eaHT5nCW0p12q4BMd9yYN7WOdrq+PdqVDNvcia1rhSUpHaKb7xoBKrlPtqvufGZ0Q+BhYrRvl17IXYrquZbReHQfm65fdTaSRNQUj/vykx0h+VI62AdX+SPfOE2iDfvnaTgsTIkI6ksmFf8X4dk7QU8DRBEtbnAEaL9WQ1OctquQY5slUsHwD/BvkITPpqjkym2rC55DpCl61eBoeYHgZ5GUxMgnf03jb/LyIIWpbzVO62bGTEKxTzpY41hoO68XZdO/89pgIj0bDuXGPFg5oQq9LNP0SoyO0zb+LuSoFc=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(5660300002)(6916009)(316002)(86362001)(7696005)(81166007)(336012)(83380400001)(55016003)(36860700001)(186003)(33656002)(40460700001)(47076005)(70586007)(8676002)(8936002)(26005)(4744005)(356005)(2906002)(508600001)(70206006)(6506007)(52536014)(82310400004)(9686003)(36906005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 19:20:52.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef3d717-f0ff-492c-0b12-08d9ceee2873
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: OS0JPN01FT015.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8641
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings list,

I have just figured that NFS since version 4.2 is capable of transferring m=
andatory access lists (i.e. SELinux labels) and hoped it would be also able=
 to transfer birth time (as of the statx() kernel interface) as an addition=
 to the standard POSIX atime,mtime and ctime.
Unfortunately it does not seem to work (tried with Fedora 35).

Hence my question, is such a feature considered to be implemented at some s=
tage?
Thanks,
Ondrej
Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.
