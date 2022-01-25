Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3649B7AC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiAYPdZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:33:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9336 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350950AbiAYPas (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:30:48 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PEnR4u029911;
        Tue, 25 Jan 2022 15:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IHEbUSM/8R+cpv0z/Y79kGU0NDmTYuhR5tNip+Ty5Pw=;
 b=fbaJ6fuBXLPTY5zKjsOEozfUi0VYM6m8RbD2k2amQwWKr2LyE+Y1n3wSBvsVJObXUw8Q
 88zGs3p5rQBXxgOSvcL4XU7Xf4SDjkrJw/8ltQ9stG7QDKntk9l+3WY7JMkwNN6w5iFh
 Jf8LtqXSJ5QOGyTvyOsjdNHmKadhP5TTyJqREtcqRH+Ru9Uf64r36vbJSDQJbjlSfSLd
 zHVwdmYQn7KMGLPT0NM42weW+vmE37U0VxHEj6s/Z8mo4Q2gQ8GWnM+XbzAj9wOyDQhr
 gu3WBA6ogBYSbAUwd+7z7zC0RtakQQPR54hPQtpGMS2QqDNQ0BX2rVlIeUrNFpM6ESqD 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7audqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:30:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PFBHtl089030;
        Tue, 25 Jan 2022 15:30:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 3dr7yg2vtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzXgjGaE52Zg406b8gajC+kkFFn5GJALUe8AlA35VO5V+oMDrzoblKDky92lLQpAiG54wJKR8gfxTjtC90RUjghU7Djm/7mQ0Sw2ks0KaaSve+zfbETnRIuJFp09jTlGh5LBzrhjuxPmhBixED0eTqToJEOT390Dhtk6iLVKAdyW/SXjw7qeVTE8p0iQWduTHUA3XtsEkIEGRmpOx5eHkHsyM7IHwQ7sMKfNIXOw3Al/mzqxnklT8kdjrQjZMu9i/P0SSbIFpBzIGu9YZ36bIRSaOAXUIf/JTM7cfEPUXDEKJxqFs6rTFDVSgyiC2Yx+r5D9icqv7Hts3TvutPJhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHEbUSM/8R+cpv0z/Y79kGU0NDmTYuhR5tNip+Ty5Pw=;
 b=We5xGO4LpYfc80b6hl7OxukTNOOxwpshgoW5IX5Ir+mU23U0zcxAMXEQkoRTN1POvBRzVMkCOHaK2CfJUpsE9i0NvMcAKe8gX0dMTfQDy1NhBT3k7jTVf81Fed4F96Y9BiDwe3a85O/RZPau0o6l85oVe6Yz0b0E/ZbFfKkzX7tNM8dhIxwPVA/N/XjuBJ59lqoLEt8ADnKjPZthNRY4Yv3rVQh5pPla2yjasTnlHMvC4DzaQAIeNYoYC+QsWgJlqq7k6BTHkwp4oj1cuSEnXHokkAHCDJYwWYgw2qY1LLkr0YlP1b2/GGMj+iqtKIyT41kIlJjjDLJNbE3WPU66Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHEbUSM/8R+cpv0z/Y79kGU0NDmTYuhR5tNip+Ty5Pw=;
 b=KzoMUjO68oKGE79FSGCHKAmz8EtuY3ogEsCJYdpE1kCpWwy6TioI/FSgnwoz8mPughbEFIo+tU/o0I9jgzkGusdJhZhRAvV8LS1Hq+H/UrZ073ARo93CZYaN/sxmrATYZrG4CPeAaAX41Uc9+zlP6R9FMTOJO4PlkaeHaJ5bJzg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MWHPR10MB1919.namprd10.prod.outlook.com (2603:10b6:300:10a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 15:30:31 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 15:30:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Thread-Topic: parallel file create rates (+high latency)
Thread-Index: AQHYELR6RkgsqUSQAkGSQQ83MPCBH6xykl+AgAAI+4CAAAtagIABDMkAgAASyICAABlKAA==
Date:   Tue, 25 Jan 2022 15:30:31 +0000
Message-ID: <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
In-Reply-To: <20220125135959.GA15537@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2958671-eac4-4f5f-1871-08d9e0179f57
x-ms-traffictypediagnostic: MWHPR10MB1919:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1919E4010114149344DB4130935F9@MWHPR10MB1919.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjPjDk6Eaa7EPej/nLooa4Gg+kDaG5ErE1ESa5H3eFr1WLl6MsaTgqNqzGUHkbtaPoQlUzB9vR5QJ1msZvqerMbJAWJ7lS5WwlGy4ETXdY5LXBx1XAueJoXXxhBfRyCIsTpRwd67/bR9b0y6jlh4bD0QTydDGuuFLln1/lRZcfKobAxWZ44ZYwTOj+aeoh6i4vmAX2967qm8UCu4nAMA1HPKOOTPocsihvq9BnreYGha4xL/LWhERatRAARInCDl+OlFULuBXArTK5KNdvcsBTb166w+dwItarXAsm8Jc9/tT+HVkrXEGUtZyCcf5hcoHH+yse2eeluSFeT0wwM8gtpgMgiKM2Ae+fPrnrYA1k1XgdtjgqWxvp6GIA6+nYzLokzVJq/W3BZ9AzSAxmJUMweiMj8doVroup1NzKMTiyJrF/FPd4xB7dB6drfL7CugkMcjDNwFiX7gCfUPMjlM6TnBQUNCuPEJuxCDHbhUTKOL33v9B0BanUIQyu4B6ddVY2H13oo7OKuiipXv9Bgfgjt5W6bNgv63+g6o3gNFx0MjtLywpYqXgSDiURC2oNEyvRdUdlkq/JI00nrkXaaMHuFvDs8ESZhQ92PGqwPjf/05T0GW0H62OCvtqMABsXXKUxU+9+gxeSdOh838pb033nBwpyrfHZaTE7/2AqAUwxRBkzhGZwSudop6eAuglIxU4tbIF4FF3UXVlRfm6Cykhr/2KDED2daOFNsream4u1sd7wF8i5UFHQESvBsBlj+T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(316002)(6506007)(6486002)(83380400001)(38070700005)(33656002)(26005)(2906002)(6512007)(5660300002)(54906003)(36756003)(53546011)(4326008)(508600001)(66556008)(6916009)(71200400001)(8936002)(66476007)(76116006)(64756008)(66446008)(66946007)(186003)(122000001)(38100700002)(8676002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QzX7Zq4z5xu0HZzSSXfrKikS3yMJ+BmVV598FICGlw36+5iNEpzEd5B16laz?=
 =?us-ascii?Q?MDvrcyvgj+y8KxsYtpu9onfV93BuWRVWfrLefNqqB7eY6oG3/SuAhUMBKwJK?=
 =?us-ascii?Q?w/VsUGHHw4eJrNIlDYWduESvHxMTLXden4uTXR1WdytV+VuVV3iIlUp9gF9g?=
 =?us-ascii?Q?yUE4Had3QN67sLeBP05/7BU91F3gVyt/EFFi1+wLpv8ea5QmQ5KwHcplFfJV?=
 =?us-ascii?Q?8IWvGtTjg0slRS7/PKoiv7TJWNbBvIHKGuAzPyChLMs0Xs2uAy7x9mKprN4k?=
 =?us-ascii?Q?e8ORMPxh1NbctA4B7nNHbViXfyOwHMNo3arewgtn6ipvynjTPaXNJrxt1oBn?=
 =?us-ascii?Q?jev3O0ZkOKmf+Jnzb0epk1QXuGepn5Il5ewnzpms4JCwEtno3m9dGUhsGxXP?=
 =?us-ascii?Q?fg29ZdC5TP2EQrGW/KH0t14+HZ9yaRtHjujwJlp08Nr617dCrJ48ZH+4KuxR?=
 =?us-ascii?Q?oz22Afvn+A8UMwFL4QwySpx6opx5gSPlBR1w9ys5pZrovNG9R/H98mXYqO0C?=
 =?us-ascii?Q?m8iyYidE7JWQKr68hJ1CkLJBv2rzUQX5dwQTEUCuDvB7XII6XMHy1z/Zpmj2?=
 =?us-ascii?Q?uVW2z415LKnzLAYS+AUwuEMAhezhPYObi1ZNVvWEKEKS03D2XoIC5ma5W0A9?=
 =?us-ascii?Q?RHHoa9PMAvu9tPqyHaOXF601vd5xd/9MKNZ5D+goFMZASdme1XjH3J853vGc?=
 =?us-ascii?Q?evhBvgyItO57O3YEhUC2u3zUyjJyLBT3TnBhk3JbgkBe3xVH1DctoF42FBnl?=
 =?us-ascii?Q?zhcOkpVK1DOJs8aYS1pSarLkVxfupF5IpqqClS7x+WGo4EE1MbinC8kw2V2M?=
 =?us-ascii?Q?MvcmfX1v2fVh2Hi4HMJag7wxeZ6676y7LDxO5DE9yhDJ34gok35jDdPrnL3R?=
 =?us-ascii?Q?mruGR9X3ag2UwxGMsgygNIlVHUDZERzp6msjDKtBqe+netp1AjFyNEix2Iyd?=
 =?us-ascii?Q?HXhFr9mrIWb1EKWiMgL3nv9nf1t27MxJxmzJb4TjnzRIA7YyQRq5Dqz7vxJU?=
 =?us-ascii?Q?qvTy/lvYPaZmgViMyrtHV8G/Lq7spPQaUMLO7gMRG3G9eWAu60E2V8GIgn04?=
 =?us-ascii?Q?PALgFrDuMlAb0g7aBQcaHJhknqV4ugrAeVXdZY6TYOSVCGPslUfO613y1sRO?=
 =?us-ascii?Q?VSMGcBXFHpYDH580Pwsfd+KfVdXBSNKsmMfUUa3erzQHM+L1UIn1q+I4ZLaV?=
 =?us-ascii?Q?tw0VmGKBz3mcjFdgrAU61DzPFoatXdor4zMOK1bDAgf/CrUtS4vLOcmIMsMF?=
 =?us-ascii?Q?ULw2RTUz68KxPFsBRp+O01TdjGTMre+yhQcmDdpoau5wVWf+Pf8kPePw1e64?=
 =?us-ascii?Q?TiiSwwBUNf5y/weDVTVqEBJcg8dI4I0jjYc3N0q3PpgMoSkxOqN1vK0ixPF3?=
 =?us-ascii?Q?hoSgndzd7bAWkZPXEMoh64KfpDF0duJ4khKHn+Rs4QdEOzzGQko4Wn+1qyll?=
 =?us-ascii?Q?Fng+PMXqsahJMW5wwYgdwl1VRa9wwvOA8dHqGrRC8Q05agBr7142P3Re0c8k?=
 =?us-ascii?Q?ONk/dmyHlqMuQqwTl5tqVz4rQxPgWF6ZclxYbLMjDbrkME8+uqex15hZMFqD?=
 =?us-ascii?Q?rlh/kJQZJUte6K+q/mswoE9WKkSLrEXVCgjZ/pnx++N8Mv2i5GBT53px1pc2?=
 =?us-ascii?Q?qTtHQ8AyDGIIi36WRkxenlc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C0CA15DBB3EEF4990F0F086459ABB9F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2958671-eac4-4f5f-1871-08d9e0179f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 15:30:31.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Bd+IXWS+ep98eQuXZ0pZXtxoVSVioM3pCoDjAUG53BueIqn8pcqBZJWtRTyJdK9GNVXdI4LhWit/MWV9wHX9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1919
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250099
X-Proofpoint-GUID: 5W1H970I5NDtjhqz6Hl2vGYP2ha8c8HS
X-Proofpoint-ORIG-GUID: 5W1H970I5NDtjhqz6Hl2vGYP2ha8c8HS
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 8:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
>> Yea, it does seem like the server is the ultimate arbitrar and the
>> fact that multiple clients can achieve much higher rates of
>> parallelism does suggest that the VFS locking per client is somewhat
>> redundant and limiting (in this super niche case).
>=20
> It doesn't seem *so* weird to have a server with fast storage a long
> round-trip time away, in which case the client-side operation could take
> several orders of magnitude longer than the server.
>=20
> Though even if the client locking wasn't a factor, you might still have
> to do some work to take advantage of that.  (E.g. if your workload is
> just a single "untar"--it still waits for one create before doing the
> next one).

Note that this is also an issue for data center area filesystems, where
back-end replication of metadata updates makes creates and deletes as
slow as if they were being done on storage hundreds of miles away.

The solution of choice appears to be to replace tar/rsync and such
tools with versions that are smarter about parallelizing file creation
and deletion.


--
Chuck Lever



