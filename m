Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E701456069
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Nov 2021 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhKRQaY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Nov 2021 11:30:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7934 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233281AbhKRQaX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Nov 2021 11:30:23 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIFfcVm020982;
        Thu, 18 Nov 2021 16:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3lCbI7SDJKCPivy11pw5sYlIX1Q9+/Ocwrv4lP/JEsU=;
 b=xFg/aOENxCVOtSu71MmRXV+5+5p/oGkYL2zTc/P3VXKyXGxwaWs+nueBXpYtifLwdE0J
 YtgRjzRcKcGgz2EVe4GSwic/YNtlNEt+eRBqlhYjnHZgztcgIVeFcnubOFlxaLTV+/w4
 7ZgW+tY3hu4ULkLeszFcZISuduuatKEOppivj2Ev/JJVyu1t3TKEEmy0B6O1EOUSYnIe
 0Ht/UqBxN8/nZ6npEQE5Z6cSfKIRrVQrrQyuoPzW//B72QgNqXUSnChTZQ4fA8HohYxE
 gmLN871RwG1RLXDXCTOjS/E0erpdfhz0qFYJeqZseSIhhvxldrsSPgyJiX9JC/7MhBIc SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd4qyqme0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 16:27:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIGALbM038496;
        Thu, 18 Nov 2021 16:26:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3ca2g0rnfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 16:26:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUKJ2wAt2wu1GRCgcXCde88H89lRP9F2WpBVyLSx9jg3Md61KSZdoQwZ+yj+QngAwa7fJ+PmKq4ZaTlJieHxZ9uCI6ivdZbt/b1j/xo/mkiAsqXp+Id1IH8BgQst3GxzRrVhvd1au6k7GMqd2PuTgR7HyAU+mT12o2v30kGCSvSMSQIJQ5AWWqJfc2gq2ti5uqqM+pH/7ruqT3bwoSo2PRXRpyJ/3zNz1y0BFao2v5+NZY9LadP7aFE7aFTxfNJVpnEh+DzL2+J4lNj4P+ri7DCatJdRZOhP1dLE6t09QK23ntLhy5GW7Kq4G2ISdwrRxQ89Ngu6Z9EJnJKxmTdoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lCbI7SDJKCPivy11pw5sYlIX1Q9+/Ocwrv4lP/JEsU=;
 b=QHGjuBvJEj606/15QVa7iD5QQwgz0OrX5m8QhdZdh6NUy1Zor11QHHx++sSaoIULspSqINCDPMl3AT7wkqUmJqSZF9rRPfCiQCSo1rT9FvUc2S2VoFdE+wsme4sxyfcy6fockmVCXezBdgSKeoG2CrXwJWpdBuKtK0AMBpiTyA4Lt5Lie8iAEmyru7jwzsFLDS+t9CZIlAVMwQsowljo+brn/SnVtRC8SHxP3X8/q8mbjj5llYcm9kNtI+diBR5AtnZ/Kcyk4Nt4xN2j+/Nb/uMIo2HljPjjQbM6D0mMO5d3/bUKVGM6etniBxhguSlsyyhnxItmP7NLM+BDeiYnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lCbI7SDJKCPivy11pw5sYlIX1Q9+/Ocwrv4lP/JEsU=;
 b=tnZh1E4HwgrIsuC5YwLMSfioJNHtMZVD8t4JEUtjdpJgp1nH/t3xPCq+kwlUl3/E6LDJljqTqsnXTT6U2uJYt7AgJb0JGLqmLKrQAdFnGpGiVddE4UxfSB6BuF2lRjqFnQXKaqEY6BniGRXVNL9v/DXWGiRZ8FJXxuK6E+dHp54=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2711.namprd10.prod.outlook.com (2603:10b6:a02:ba::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 16:26:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 16:26:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
Subject: Re: [PATCH 0/7] Cleanups for NFS fscache and convert from dfprintk to
 trace events
Thread-Topic: [PATCH 0/7] Cleanups for NFS fscache and convert from dfprintk
 to trace events
Thread-Index: AQHX3ADv2oWEXSsDwkedfJbhYLskMqwJejAA
Date:   Thu, 18 Nov 2021 16:26:55 +0000
Message-ID: <A26894CC-ECE3-4168-8038-1D05122F4A0F@oracle.com>
References: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55c86922-c340-4e73-7290-08d9aab03cc1
x-ms-traffictypediagnostic: BYAPR10MB2711:
x-microsoft-antispam-prvs: <BYAPR10MB2711A05BDEF2B255172E63B8939B9@BYAPR10MB2711.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rv2PF+fbcwyeYiPj8r7/pbIDXMZHn7OM2mLIpTc+E+f+9GXWPN93cndSfWItOpNlQlT7PyHO5vQSImYto+k0TjLyqju/76FTpJJ1rtS1f50P2jYIe0dm20n5SK/WdcjOSJlALLDIFs+s1qYQ793yBWYsuc1Om+aAeLVKudhrGBadRoCleLFJL/9d/auUxUrTI05wSSsBFPx4zcxkf09a8Lv+V62tzCrnaG4CbAapNJo2oLWM0bG0JRA1JoDSEBqO1ZHRD6mw9Bj8cQl5pNAec2rgX95YIIxYvyjq9+UfGP+xSTTevIANePxgcmiDjGCbS6Dx/Rs7K7I4HY+MaU5oArhxWapok8H4JQ1Ykg0S2eRzFpZZxutHmcts5oXFB9I3gsm0sukTBmT4plLDrFezQ8vzBUMei0Ow0Eo9M9+dGVNzQ7K/YdX7pEIMy+L+O+SfyNzmHtjtg85zGKXlkTDVEgT+9c4RatY807I+Px0OkGS4LtLOSXEG1MPKZHWI1rzHGcaB8EpK1wf5gZY7n+mCX10E3y3hMxW+TSqXGeKEVKlLGbt1Lysk2DRKkxX+4DWTEFHfov7unpuROjJ+/oENFvRJD7/1wpE5O5sMffuUheydqg8cM/KyJRdLlnkN1C6hKTOPFa27K/DxpoISgDkO1Hvd1L8wJJ0p3U7e5+UMiYVBRgU4RDZau6Bv2VI/mKKQ5LjI10nMp1SJz09yu5LwEW8J9WwvxPGpTNpFRFblP4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(26005)(66556008)(316002)(66476007)(71200400001)(53546011)(36756003)(2906002)(4326008)(5660300002)(6506007)(66946007)(76116006)(91956017)(83380400001)(8936002)(38100700002)(6486002)(86362001)(6512007)(122000001)(110136005)(54906003)(186003)(8676002)(508600001)(2616005)(38070700005)(33656002)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0dO/EGrlJJSinsjwuAUYfiy1XBL/Tdo0GrptlAQaK4oIgHfMKcUQq8Ui1c9?=
 =?us-ascii?Q?uUrRYmLg6qdbCGrknhN+NJR0j4/jPhDS8X5vWHjV+cxLQuhdUbWhqX0fxGi6?=
 =?us-ascii?Q?tjbNfnhyHACmnN6OguS/5HxGwSbqvqJfwNwXDF7b4ZV1eXXFirRrTiUfP/X9?=
 =?us-ascii?Q?E4kxKO+nPIlrjfDyXySdWVGtDB/kimYxWG+8vj9te53c5w+KJlj1/K7u72em?=
 =?us-ascii?Q?JsiZU3QNmay02MOzyrck4i0AoxYWQ/iBxQBsKLXIEGYlUsDZKlHRIMhrHcuu?=
 =?us-ascii?Q?aIILDsiuYVsOxXnHZXRV24wB0f6IMdAZjqKM4nwSOnCXrNA/JRCMj2a1hfvu?=
 =?us-ascii?Q?yaqoejrR5mzIlNKXWlwnd/6uq2XDcT/E2bQm+KhCaOSnpDhbNXOsaV7vwYI0?=
 =?us-ascii?Q?Byk6aXck23753ipRdiYj03voAebEYsLJNOWbq61mxcXElyWx2zLkENluGcwy?=
 =?us-ascii?Q?zzKGth8ETLWenotuAezh9NL+0s/hy8LrDbG0HoxoI+UUISddFsx7mHp+KxY8?=
 =?us-ascii?Q?c5EXzorYpTv10npKMgx8Avnm+jAKxoN1a9UJcCwtPBb+X55m3SxKFyAFFpiC?=
 =?us-ascii?Q?AjwHXwo3BdHUBTSDVpJsICiMjqG+wnPapx/87s2mjtksyNwXuSoKKCuzAQkq?=
 =?us-ascii?Q?LJdAM3e5APyWOJ3TYCrjh5mfYksWNqOe0l1g/1f1HiRtBVrG5QhReqcK6ey4?=
 =?us-ascii?Q?NdJNVLO/wP5zaO3ajX69kTudYcgS/omaKmwD9lKK4NKnN0MqZwK5hRfsmcU+?=
 =?us-ascii?Q?gP73LcU09+6brtRlsjcsT9GP8NH17beFADrtTZwZz+cNamz/iO7Z1qRR8zIo?=
 =?us-ascii?Q?stsZBTxKwo4X2vGlmxLGg6g2+F+OiXA+BoR8Wld4+yd0M7mB8IhUVzkZCSVr?=
 =?us-ascii?Q?1Mn7M1HuPF9hx69C8Eege4pW5Di4scZ87IJSLr6ATott/wgzHLHSfZlyyVz5?=
 =?us-ascii?Q?cUdu+1RL5MdR7BH2HjEA3Ttwywupmuy32PaaeJNXG/Ls35XQ+dySFTvPWAx7?=
 =?us-ascii?Q?YkInG+bL9Q2pxSEnLy4CQn18GSAbN02gZbgIDJgdr8A+IA4qc/s7wNNeDcPe?=
 =?us-ascii?Q?dt7MMIylGgp6Djw2sNcRlMQVhELy7FJv4ipsAabjWkGlj4grVrFRL4kcgzzY?=
 =?us-ascii?Q?JwP9vZIveT4qh9dyPE5sTnRXwfer6PcIEQv1lgC/4zeaWoYylFcnWKJw5t1p?=
 =?us-ascii?Q?utngfcmHV+Y1KzIFwc520flzyQuizdmf16OX+X4RVVYw0sCEXQBheDXcNr5L?=
 =?us-ascii?Q?1DkVVHwcG2AcQ0kpWUv9P1Pq2bhPcd1b+FULq7SclQ5TAgMZVF3+AyGOkHcA?=
 =?us-ascii?Q?zD5Or1cFV0hpXXHdcJbkaC2kF1cWx0imBbxiaXt1v1XTB+WNtz190+yBZIv2?=
 =?us-ascii?Q?orsm2LG5/vv/V7OLvjlVEzjxCDZecvOvT+5dF6eV6TQ8ZMFKjsmAiajaL9nl?=
 =?us-ascii?Q?bfdzFgztt09WQVMMzyZg6123fsx4cc5AizaoN34JP85F4anCI922j9noJn0s?=
 =?us-ascii?Q?qgjUBLSibLqfD/fyJPGvc6Doy/FRNQzSNqEh6w3jq4QSaIB/V0b/tLG1Kb0j?=
 =?us-ascii?Q?nh5mliBjeCFpJm58JqX7k9rQ7lU4PM9U0Ecbcct0UfuOq6cnD4+O1EQzqlJ+?=
 =?us-ascii?Q?ijoNz0pr/GuwxZdou7brSpE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <021CAB36C9F10043B8F042E4AD5BE44B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c86922-c340-4e73-7290-08d9aab03cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 16:26:55.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejjNzX3vEHZECnxwXBOZ85QQ/RDWYJhEDV/iYQbniE/hmrTz0AuR2zeV4nlbxu72J21ecMCIBJ/mCLn3nuSZ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2711
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180090
X-Proofpoint-ORIG-GUID: d3bGPbHmIAXGXjAehwp4uDBVnsy84mwD
X-Proofpoint-GUID: d3bGPbHmIAXGXjAehwp4uDBVnsy84mwD
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 17, 2021, at 5:17 PM, Dave Wysochanski <dwysocha@redhat.com> wrote=
:
>=20
> The first 3 patches are cleanups and refactorings of the NFS fscache code=
.
> The last 4 patches convert dfprintks to trace events in the NFS fscache c=
ode.
> These patches were built / tested on 5.16.0-rc1.
>=20
> Dave Wysochanski (7):
>  NFS: Use nfs_i_fscache() consistently within NFS fscache code
>  NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size
>    properly
>  NFS: Rename fscache read and write pages functions
>  NFS: Convert NFS fscache enable/disable dfprintks to tracepoints
>  NFS: Replace dfprintks with tracepoints in fscache read and write page
>    functions
>  NFS: Remove remaining dfprintks related to fscache cookies
>  NFS: Remove remaining usages of NFSDBG_FSCACHE
>=20
> fs/nfs/fscache-index.c      |   2 -
> fs/nfs/fscache.c            | 106 ++++++++++++++++-----------------------=
-----
> fs/nfs/fscache.h            |  33 +++++++-------
> fs/nfs/nfstrace.h           | 103 +++++++++++++++++++++++++++++++++++++++=
+++
> fs/nfs/read.c               |   6 +--
> include/uapi/linux/nfs_fs.h |   2 +-
> 6 files changed, 162 insertions(+), 90 deletions(-)

Series Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


--
Chuck Lever



