Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890D0447109
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Nov 2021 01:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhKGAGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Nov 2021 20:06:14 -0400
Received: from mail-eopbgr670061.outbound.protection.outlook.com ([40.107.67.61]:12211
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232936AbhKGAGN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Nov 2021 20:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3cISf4Zplw/JLgXFFs6QeCWowontBDvSZwvo/Mh2bgFtfDdB31vH7Y4dDRwSpfmCxA5jYNSLk4XD+ntNTY+RY3UMv6t/gZWwvqDnQTi3yi9qccSXNZ5bWs1DAhBDUT8fBU6tQNq/pKyecWCYak5EdMqd167wqr2vaX08ApKKSKzR2+bFUDcusS/F4nV0n7E89tJvD41pA54sv/5ZPT90bWd91JI+GOtprZK0kMeFo4rUEqLWEKvZwrAQor+2Vjak8Oik5V6LjzGmhIHtmkkk9xmLWiqCX9tFbir6KqCF+r53IARk0VUEAUEVltO78FI0LCN5j9X9tvFMAkYQzl8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaaEt92MskYFXyOz+z1JGPzN7Egn4GKIfBfqbbK4nI4=;
 b=FbRs9ZxwVnwkpyhmVktKIrZ8n3W36qcZ1gm/WqpUtlEq91CZvT+HHSokRinwuIh/0tbEsoEd3QagC1Wmlp0HiUu0GVF++eKgdiKOCrOSCisdSyBuFBddcWwaM34WWKFP/Mepgoz/gyZM/EC29V2T6h2xA1xLlaiwTGybJyWPQxVWWfvhNQ+xqmHTYVpjDWG2XITrcs1JkYwMrgTSrzxwgcHm1u6w53zR4KiIVRbn+GNQf7rlvV93pv+hdaJ4F0p7gn58xqeQoZDMY8vhp7U/uhXEFLVWkceW2v37tqAY61e6TXJO8fl7F64yKkBArZpme9iJD/w969TRD4OHoDl48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaaEt92MskYFXyOz+z1JGPzN7Egn4GKIfBfqbbK4nI4=;
 b=lt9OnqLw+nCC3KjDbzY986dtHLeV0BidRL8Zn7sM/Zle3F4DqGGOGpqW9zG/VZ7UtR8wi/97mN5jiuLHD5AANXfi/GgrigRWpZaKSLObIJlhs0kd7heByQTxXvQhAApsnlQ7bWTeulqhMepR8WdrdU4TIOuhEiUXzGcGC4aPQFehnpBHqtP4DI7cLP52FaFfbrNgvgXXqbhFrSlMxqHWXGpvKxnPXvaDtex2W+NN0PXtUgdbTsD70/FKDiN8s1XvM1BKxN0cCKGwh+9R/YQI7P2P/3nxUnzYdxt+xqozoAdI5SYd+Ydw9l1yRFP9WpeuABS5nytqJSIFMn6Cp10FNw==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB6171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:28::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sun, 7 Nov
 2021 00:03:30 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12%5]) with mapi id 15.20.4669.015; Sun, 7 Nov 2021
 00:03:23 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Topic: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Index: AQHX02npTtMx6BHF6UKeTijQBaPp7A==
Date:   Sun, 7 Nov 2021 00:03:23 +0000
Message-ID: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4a4a911f-92a6-ede2-59bf-3147e797e204
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b89ec589-f148-4c96-912e-08d9a18203e5
x-ms-traffictypediagnostic: YQXPR01MB6171:
x-microsoft-antispam-prvs: <YQXPR01MB617155305AF1425DFD639FEFDD909@YQXPR01MB6171.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/grbzAResJ3/+TUvE5yBgo8kjG3fupqzhhb/PBFBNSFRIXs9/hf7Aw63tJoPA+SjuHbXRPhgJ41hDSPJoA8Iut5S2UZ05X7KlC5A7Kx0cxLCbvhjOGufL20ZyWGNiOqgBMOdGkJrBOqDHmHT0R+9ABrFllQXOmlYyBfhZ3YbbyX+Dn+wKFRHMtmiJLAvKWhWUQI9MbLVnSmWoqeg67o94Wd5ZUy1IY4jSx8fGcC22BjHP4xRQE8iBQo9o3wmy6Wa8xr5oluFGSG5QEf9F0fFiqchycFQwkbI2l7Ej+2pG4qSqnOo7AOh0hJYXBryTTSvz8zPqKl4cm9YZX2P4U9oppQMqZzVNesFl1GdLtMdZ8vVEZQDSIRsmZY7N0ylo+7S+MKHBY708KpS5sv2Edl/Ywyf75IE72IkbtL6MC970E91aOk9LtlFXc5ncY8viYP+ag2A6+DDYACvtG9gd1fXaYxNuHk3SaciW+ljp501h9eod3xnDZMe60vgqy4vepzvdMnLF16fXTqf2EaUxzp3XMiibXXnDOko9tXmtkFCLCKScWLhAKtcYsXY1UiqEuW+1YKa6XTsaYwc6BMSEtCNVZiq3OEzGzcDEGRkZZ1U7Nq2hgT1soeBDbJEuHb2avOuikiORnlwd+92r7fM9gyGFkKvZLJDdz2l5HTZ6S/KWT+7RdxcdDcjP/yWTzsdsFGZoMmWJDkOdZ49L5k6xpWmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(38070700005)(122000001)(38100700002)(55016002)(71200400001)(2906002)(8936002)(6506007)(7696005)(6916009)(508600001)(4744005)(9686003)(52536014)(91956017)(76116006)(186003)(86362001)(8676002)(786003)(316002)(66946007)(33656002)(64756008)(66556008)(66446008)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cpJjlpd92fXfcayHOAAOCPDV906UOdcjJwJHnUZZw3dbB5bnLiJeHwNN2j?=
 =?iso-8859-1?Q?X9QvGQFER0KqxOKyuC6S2Tldrd9w24BAygbFITkghphpYEGSZCEfN4IrwY?=
 =?iso-8859-1?Q?dm4eZKc9QhKxMK/lE2yVbZQXWbCgxs7eDJ4gD/hBoErL9LyVXcHuGm6kFG?=
 =?iso-8859-1?Q?Wp8g0AGTYSR/JyqaaVUavt2R8t5eConVb58D4ldbIemePOS1Rwb4Hu/+eE?=
 =?iso-8859-1?Q?kOr/s7jQs+pf5K6nyoK/oAWlkFHcuutzQe9HlVFHL0qC/XAl3Z31OlDjO2?=
 =?iso-8859-1?Q?gCNzV/vC7SFGAOjvra4FG5Xza2GzQ/Pdb2D+uNLNA/WXeBMn/JY1qQmrBD?=
 =?iso-8859-1?Q?S3CJY3/VlUn/yVPte39un4kvkoGhouOBMkAa+z+mtrav1sl6ysv3WxfCDm?=
 =?iso-8859-1?Q?wrMGM1N1xBK4vg4k9lTeGF+Bl/SeRxi5gF+goVVUo3tV8Bu3dMHyUiFtqo?=
 =?iso-8859-1?Q?xzTEhZ4yMgZ5xUxe1Zx0QX9dO/X7fbMCr0an9QtqAuGsWXvRVrsQ7kOUZf?=
 =?iso-8859-1?Q?BJCIgK4C1vzqyg47hgrdoL7nIChPF8mSI7adu6yeJWGhMCg9kTnzFBGgLw?=
 =?iso-8859-1?Q?BEmzTM2Rb5U1thhZrz7bJ8zlam70vD4jp1sI4UZks21xTRgvsGrCxY3ml5?=
 =?iso-8859-1?Q?azJ76g3EvYoeFpnVgIBwnWJg1oXFdp9OLV0N5AJeb+lM1W8STypa0jaCSE?=
 =?iso-8859-1?Q?NMK5rQvUAwSmORnfD5vGDhRXD4QmMF57sC2kxcLF8K2eQglT9Zh+nFbQ7s?=
 =?iso-8859-1?Q?vxOcqYYCpAEFqN9dlILpHL/w+Ctuk84/n95ZwytXRYk3Jm9sbOsx4mva6C?=
 =?iso-8859-1?Q?qMbscRKjKdBi7SvYm4tI/XHtVLnOVyeOxXl0DSvKqbQLEdqRJsefE8rFFm?=
 =?iso-8859-1?Q?50IlcLTeFcBrgnCjnEh+bowBDy2vIv3FE9M/4LyhHRmJpqHGYsWBJ0D+/1?=
 =?iso-8859-1?Q?Wfv2aaXm/KIkydsDmz8hlGSts54Jk+oxn5p3ZWgMyar4e7H2AGj9kvdjWq?=
 =?iso-8859-1?Q?VVlGbU/fWNTyK3YGl5h5wdQJG6QhZKvCGgyZl8VxEdCilZ6VYML2VydxTX?=
 =?iso-8859-1?Q?6Lssb7JCq3rNfe1SgyMrOalhZ94JefM/VeR66qT4ydyZENr/CkTJt+cQMQ?=
 =?iso-8859-1?Q?p7FcmYe0o7GEvu0IUJiJmriohc2mdfW2xnGdlGi3mHgdqR+/oomOUDKlqE?=
 =?iso-8859-1?Q?Hs45HRY/X5yOqcj+r8XiUUioxFkMfAjgDV/+hNNtZX2LiNiLgHxQ0WA45k?=
 =?iso-8859-1?Q?5iGlqgi36IponloDdANxAp/YeDXO/QMHVdj5w9FSH+RpXtLobFAyqDLeaE?=
 =?iso-8859-1?Q?jnpdHjj3FbITsLL1rh7CWkQDTDn5vpKaYKnx59mEPKYkSh5w3KYioT7iAs?=
 =?iso-8859-1?Q?mZTwO5VQw/TWSY7GvquZKhhKLiuCUtr+W0/r8Hj1GMmWfrlE4DiQqwM0ty?=
 =?iso-8859-1?Q?AOYjkxpqoX+fK1B3IgD9/tq76y8k6E+SbiTyVyo0smP1BnXAAIsZ9e0sKL?=
 =?iso-8859-1?Q?67e7ItQ9SwViTvXiY8bwzeyoxOXvRB075B1lAH/s8srBIfTo2V9/tEYhqK?=
 =?iso-8859-1?Q?PId4PX13Ow1R8e3vavnXLi+C2Nj3olaqATow/Tb4Mf8+TQFsnvBn6vcmZW?=
 =?iso-8859-1?Q?ogxVFKPxrPsW5LWRDwUxrczl2gFrhqYF14FByER2WuMYbR5uPJdk8v4wrY?=
 =?iso-8859-1?Q?WSODV9PtwqNmWT7qfsk0394a/f+0XERjE9Wk+nguAGDrtICZv+nl79CNY+?=
 =?iso-8859-1?Q?/5/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b89ec589-f148-4c96-912e-08d9a18203e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2021 00:03:23.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QftbY6yajRl+lQufEWEKFc2xYaC9L0f5aej3ht7SQCm+69n/fmEExHWV0a0R/AG9O5XJ4SzyqTW6BzpwInRVXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6171
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
I ran a simple test using a Linux 5.12 client NFSv4.2 mount=0A=
against a FreeBSD pNFS server, where the DS is out of space=0A=
(intentionally, by creating a large file on it).=0A=
=0A=
I tried to write a file on the Linux NFS client mount and the=0A=
mount point gets "stuck" (will not <ctrl>C nor "umount -f").=0A=
--> The client is attempting writes against the DS repeatedly,=0A=
       with the DS replying NFS4ERR_NOSPC. (Same byte offsets,=0A=
       over and over and over again.)=0A=
--> The client is repeatedly sending RPCs with LayoutError in=0A=
       them to the MDS, reporting the NFS4ERR_NOSPC.=0A=
=0A=
I'll leave it up to others, but failing the program trying to=0A=
write the file with ENOSPC would seem preferable to the=0A=
"stuck" mount?=0A=
--> Removing the large file from the DS so that the Writes=0A=
      can succeed does cause the client to recover.=0A=
=0A=
rick=0A=
