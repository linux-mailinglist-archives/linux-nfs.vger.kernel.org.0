Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4433E3D12
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 00:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhHHWro (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 18:47:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61712 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhHHWrn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 18:47:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 178Ml2xB018993;
        Sun, 8 Aug 2021 22:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1XDXbUiTtU0HLzOqKGU2xtfN1MMZISXNKYTgPufjesc=;
 b=ftgS+gX09IYTycUnmfUVYQuAoDzf3W3MShrFkOYveplwXmL8YiVH+IT+H/jUz2Lm96Mx
 rCIzOt/JjfZyzZBb20AhelQK1WbW+QpVVgE4QhYqfhsG5qDPwO8NRHm0OTjM9A2BWL5B
 GRj3JZWeU+RgfxcxOged9FFq+6A2VUgEIQ/A+7cGuEtnpPCBiDs54YfDb6czCbSDJGuo
 DrByJXL+oDkdq4eCGKDmC7efK4rV5ekZ+D14YORc2wuLCMamLPWhIm/8DK6u/zXFp2wT
 7hT1OL59YQwsygQGikn9ZjmhgXpN/iRIFltH6oUSU+BsZ+SeIyvgwq14+0NQVr7bBsnE ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1XDXbUiTtU0HLzOqKGU2xtfN1MMZISXNKYTgPufjesc=;
 b=QOacpAnS5qk1LX2DZxDIgmxkQ5ub+2/6Z0BHvWIRouO7CkBE8J8Ium5r5Cw5XJhazXjr
 vr2auTAH0muepin63VF1ETSEkt+oJLM4KyVqyDbewmepV1Gak8OjycTfaTAD06xg4AZH
 BDHYZZtSuPs1Kw8ZmvjnDJjFqZ4mi7UH++cOui9K6aw7n+9G/+TwEJMEf2mq7lll5jPg
 B5ICBUYaD79EB4bnJiRHqnnzUujTLFwjixvVGyPEEnbikzGwXo7G22jycxH8Yl77Sl0S
 HfciTzNhgxe9hZTPprRWRdNNrkhHLxzmYLGd+AL2bSixRmUFxIVl36qyA5oRnLZGAabO uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9hsshx0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 22:47:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 178Mev26063781;
        Sun, 8 Aug 2021 22:47:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3a9vv24ta2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 22:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K11pnzAkjMb582NfUT49ZdI5HMSGGksocbJYSuwTNa7TNytFKvpSc65Ki4+dQSsndaFmA8Udbx7ciBwT3GxBTf0TtqWI4hry3LzM+KFFbPpR6H1W2rJ2Qb0TedTFndCJGPhBYs1qktfSwhXPfDrWIxht5Onc0x+sWFiD2yLhrrlM+G8KeCB7JJ40UtI+H6EQAugleeu9agN3aYLXKNCRLJB7tmZVG+eEKXdQ3oL7tTRH/Te0qtiLAtwd0m5Aov3Ry5lpCxwc7xxaiYJ7IXOttJzvnN/H2gxVbAxqIA+uO/kv2ZpnhIQwpDxGvhVvYpRdiMsZYmk0YPcLf52BGuA+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XDXbUiTtU0HLzOqKGU2xtfN1MMZISXNKYTgPufjesc=;
 b=kz1HuBfCMmFy08N3FMu1YeEWAse3Xt/7gYHE7kgk8fQUdC7pCMurIIMse3VJ3UoKxythQS3d2qD6qGIdQ6NMljUSTaMAoh0l/pnET3uZZJPmJHPJ3IrzmhfGnQqQjFW+UNbRV0DR1JSYXDYh/sRko4e05oIauzd9QwADpFqy6ZnoBRU9uh4XuIlOUplCq0nFzLFycMtx/u59WugXj1lACpk/3Zg7PzeLnpWlZKHEt6RwiXMYXSLM+Ps7xvG7b7Kh7zQJP466hnOFqdQDhbORb6nHqYh2g7Yp92knNYCVMtSnyIga1OMlygWH7Pp7nKbCBcRw0Sn+nMbZbntaNsS63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XDXbUiTtU0HLzOqKGU2xtfN1MMZISXNKYTgPufjesc=;
 b=rGTR0q4U2xymijNRsAU4cUT0K/CCwPUeQLUh6GSnEVZJQLAhIjwlRH4rMPrKi6NZOeR5qTkx1ZEusqTNLtruZNn1y3hfTAnAMZevRv+GRDGxYYstNGkp97GZGFvjj0BQLXFVGkjWO5LToKp4Zk8oYnSesRQSixWkiAv/TqRf+a8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Sun, 8 Aug
 2021 22:47:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.022; Sun, 8 Aug 2021
 22:47:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Javorski <mike.javorski@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqNWCA
Date:   Sun, 8 Aug 2021 22:47:18 +0000
Message-ID: <3349D119-2F35-4A58-8061-A2659E8C6BB9@oracle.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
In-Reply-To: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e48a468-ebe6-4a4b-cc26-08d95abe7a27
x-ms-traffictypediagnostic: BY5PR10MB4387:
x-microsoft-antispam-prvs: <BY5PR10MB4387A8025ACED2A25142327893F59@BY5PR10MB4387.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jab0mqm8bhZGh+DFC8TtbdQSBr/NgyGMFJ3SkXNrS9wxVkSilRRiIC/9bedDN5y/Za6OHEOT4RFf+Am1e+eUCOVQBFaRWb+9Q+R84UT2GTXrm1bWWpH68uS3B+u3rI5lJhzTyP6Pjbbykza3dtli0f+pBcgnFqNKUBDnKlfk2BZtG4vFPezcPg6Ed6ux8Yrj0Mg9SdbZ/ciSlPfZdHIThvvKvhvmgyKv+yL5r2GQXT0LdgPl5TAkahMqk4bLJf+RSKGaQ14+AnRlpevt3g5FMbb0YYWnNbJJgt3U/mcnuWkHKibump21kQJOcgW5hcaKiV9FAm7jXC0jpl8AgxFbjqv98H3CjW4TL8YBDY3iG9Go4UA2QawJL9kmreDGKWy3zhToXp+ODp1+AVRDpudOnzH6W/F44uVatr1iozF1o/SKj/pOE7u8ylo3pc/U74WB/SbFThHJWtEMw484FjVc1MFTPueTFDN2CWr37MNCrgdLtiSyZ8ao6HySDz1jQ9PzRyDZdwz59xPCmTIBJuFrDiXlmMOQDK94aV1liuaKDTM7eMjn+iuqfwEU4Re/JCBUF9/HjuZzJPe6qjJQa1Zb+nI3SgT+h3pHSZekAU44sgePaPWgPEwvvrIjUQUARoiHRelzTY0OQG8DPbVhcGbxow/r7Z/LjxF2+8wQ7daRIrh7WisSjwuvPB57WXijpslBCIvTyYvC/DPy1FQYLSSDRFyzPSRHGB4d3pUTX4imjw4LtUFbIsTMU579rbGLtbkF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(6512007)(2616005)(2906002)(6486002)(8676002)(71200400001)(53546011)(86362001)(316002)(6506007)(6916009)(122000001)(36756003)(8936002)(38100700002)(478600001)(66946007)(66446008)(64756008)(66556008)(66476007)(91956017)(26005)(76116006)(5660300002)(186003)(33656002)(4326008)(38070700005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6oglu2mXjMp/esOThB0gJvNxLcmpgx+k0W640W/4IwT0Mw0WTQivPt+Z3GpC?=
 =?us-ascii?Q?Dm9CHRHSSkugceikKmdJnZ3Jv7MwBdUjcRy77Nq6yZmC5CjcUtgmzFUYp+MT?=
 =?us-ascii?Q?c1KWJSnf3BhDSyfumPjLEz4yhSmHWgzd88o901l1Yrit+z5zW0yHmCCZRebc?=
 =?us-ascii?Q?ghgM408TgJLC+uVuHNlBgELApsKmvB3DZwFeY7E7n05fnqkIANQueLEUFAiw?=
 =?us-ascii?Q?SoNg1kKyBLpRZjSnTHEY/5tRoyayRICkQTS1S5uXJVB2kkUMPG+9DEevqezi?=
 =?us-ascii?Q?mjVMh+fNXYwL9ebc8Pk+8QxmSomvbZ2e3m+jHAcKUParZtUXIaTv2rT6tXMm?=
 =?us-ascii?Q?CWltklmcOzbQtrxCGkUY/+xC2W4tu08YfdSW8P7soHVgVRn9nmFDuqUqF9yo?=
 =?us-ascii?Q?9pgUliBUZiyrIXUy0cIUzkgWK4f4YLfPeR5Y+POgewsTvWntFHyt7nwXrhQW?=
 =?us-ascii?Q?ycQdDtFywj/VpCw9VpPwbu4fk3jxQQvUlWJ1v3Nx0qPA7lQtpEsgWmVVLtDp?=
 =?us-ascii?Q?wXARuHmm4vkOJeNofa+DEWC/6ULP2dNldCf3JUaCzOdt7Gqwc0SSKbbqmwag?=
 =?us-ascii?Q?hOVaTfYjOkigIUUgtgg6VfzcLjJ/8kCXOr24a4YJTik5gWDgLKoP6+PhRegC?=
 =?us-ascii?Q?CIUKjfrMVCbnqcmDFtBwSWm4YqfXIYpFqXLsZhDCeMVzcjFSxPtz4H1txoxi?=
 =?us-ascii?Q?pzPfIBkTHS7ULWz/4N3Q+IVNm0mq/lfGBrWL6stQKkiyWS7VCGrPXKcfXEMA?=
 =?us-ascii?Q?L9Vg9kgb2x/RdqsqUG5umx5j5XlwnjME6OcxFSl1UzJAOGABie4bKKbnDgVP?=
 =?us-ascii?Q?WOO4642agUMDGgx6+T+lQR8WLIMPc9t/pBBJQ8MGPH2WUxA4HicVyFPoidA1?=
 =?us-ascii?Q?G4VYjdvy56rK0KOo2N7LpUzbdmuERa8tNwRZPAqt87o/4j5WknIE+Om/GPXo?=
 =?us-ascii?Q?1gcSLzqIjqz62i/tJKhkh6jsYHxCtqakD1hBn30WiHLXOQnHZA+8U9RlGfmw?=
 =?us-ascii?Q?qtHxXG5zYsdTykZ/ghK/t6sCbJPX3JBSS1qwH8hhnRlB8L1aVFNkDPiVH10B?=
 =?us-ascii?Q?RGwJZGf98Qt5cvutKmmTiX2qfRZ41waaXY+PYe3LNFcXKaA3Y9QjQFxTUCNr?=
 =?us-ascii?Q?Y5WaFHXltXqQO8CDKBsZUxLUL/mO9h05w748220icr7GD8FZrLiq0RMo3MUh?=
 =?us-ascii?Q?N9m2qJyF9S0nCRwwFEXzfCB7U3cEqfXQiAwKD41UZkyl5SrbE1yv2YzT2n+Q?=
 =?us-ascii?Q?P9abDqrHpB7pU0vx2Gc7sHVAwE8+/y2+DzRroUvZtLA9AHp9K11u+iJt7DVp?=
 =?us-ascii?Q?JYwzGxGQ5b3kiWtebFhRxS6HzCyJWRrbZaFaeaoQ1BxKWw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A82F161E405D754991F9A117E39FA440@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e48a468-ebe6-4a4b-cc26-08d95abe7a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2021 22:47:18.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nA5ODeW2hh6zi8xY+H4fPmTSXjrX6oY2M4zu9C0vS/FAAR+gDC4mFLez6RFtt3wufzqgjtHZIgV5jriaWXD31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108080144
X-Proofpoint-GUID: hNz17CSvgLH1jhPObkMTuWYn8PLbQ6RV
X-Proofpoint-ORIG-GUID: hNz17CSvgLH1jhPObkMTuWYn8PLbQ6RV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 8, 2021, at 6:37 PM, Mike Javorski <mike.javorski@gmail.com> wrote=
:
>=20
> I have been experiencing nfs file access hangs with multiple release
> versions of the 5.13.x linux kernel. In each case, all file transfers
> freeze for 5-10 seconds and then resume. This seems worse when reading
> through many files sequentially.
>=20
> My server:
> - Archlinux w/ a distribution provided kernel package
> - filesystems exported with "rw,sync,no_subtree_check,insecure" options
>=20
> Client:
> - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at wri=
ting)
> - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> (ver=3D4.2 is indicated in mount)
>=20
> I have tried the 5.13.x kernel several times since the first arch
> release (most recently with 5.13.9-arch1-1), all with similar results.
> Each time, I am forced to downgrade the linux package to a 5.12.x
> kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> and stabilize performance. No other changes are made between tests. I
> have confirmed the freezing behavior using both ext4 and btrfs
> filesystems exported from this server.
>=20
> At this point I would appreciate some guidance in what to provide in
> order to diagnose and resolve this issue. I don't have a lot of kernel
> debugging experience, so instruction would be helpful.

Hi Mike-

Thanks for the report.

Since you are using a distribution kernel and don't have much
kernel debugging experience, we typically ask you to work with
your distributor first. linux-nfs@ is a developer's mailing
list, we're not really prepared to provide user support.

When you report the problem to Arch, you might want to have
a description of your workload (especially if you can
reproduce the problem often with a particular application
or user activity), and maybe be prepared to capture a network
trace of the failure using tcpdump.


--
Chuck Lever



