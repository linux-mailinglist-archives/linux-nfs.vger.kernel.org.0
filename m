Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A047A200
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 21:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhLSULm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 15:11:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42354 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhLSULl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 15:11:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BJ9fGWL006157;
        Sun, 19 Dec 2021 20:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZHEmk25anwLKXF8XyjhGevkoC00e/jHhf0W1mqEBMig=;
 b=FkLhuMytOhd+uhjmYbk0zk/YnEeTOTJo7TQFp7g3Z/Xowmm4Le3qjo8nLLWpiuq5+YBG
 sONcmoj2F+kH11c5MKNktCF/3oVm/gKd0robRUNr+iWEXeuxU2McqUHKUfFT2lIEl3vH
 vvkMi5H9h5JAXO4oNres+mN31KTgUivR3r/G/desOBqaVlh2etKkETl0Sc4H5YWhAICy
 4/B3IGRQiy/6oNAtBVswJY1oWb6fYEhulRAo1S2Lxy98OgZssnepcgm2041YkFlJ5szY
 18iUuePG1pyhS8TBVfhgL8Zb4BSlTbsADmT2QwgbCBZh7P/R1eYl0AtFYhx+6I4lx7ZE sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d162c20jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 20:11:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BJKAJJR144264;
        Sun, 19 Dec 2021 20:11:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3d193jvatc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 20:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKKRfTAfPRlHCg9L81vnje6E1o0/k3edHcg5rqGNp9UFj0znAaoUwYK86ptqCYlGUNKz936V7Uc9qI0wU//VnQ4A1KO4+mqP4CmwPPY19pRoNsx5jATX8Md/+Xoco26bhSk6mbivqNWKSURXmOuFLIYfZw9lOqN0PTD0CRpu/wa49IgBctAkKPFkV7Bqg6Etk3vbQIV2pytqEU/aKFvX+uVOe/ZPUxKvCVHtk2o3TRHMAuIrqJjc35gVrSzWa3nzUY2vBfBd699jIxNLiSD8b/pa4VQnK8g7+evXebVPtQzbxJqiWeeMGnwA0ck/BDFv4E0jm/MzxEl4tbm8RJgzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHEmk25anwLKXF8XyjhGevkoC00e/jHhf0W1mqEBMig=;
 b=QmdwjlQ+P7mqBE/zTBhr3otV3rTpGRUGyxhtW73M/W92gOzMXwmIqGaAZZHGZnQsLSvrD5R2KPSF2CfcwwL+WQ6LrpOSSzQtcMUdpbWo6oxkvouYzF6xmQhGIR6btxc55eCYnMkFb7Y0P0rQldP8KLusy8eWzGfrlyRZRPTcNMRiYPuOMf2dinB3VXEoNQN3J5hxAmgHVDkAWBqokSkvIB/W6gZMD3VSYhO54Fg+DM59fmvnMP+daGHwO+8xDz697VjLUNs4snmimAorPpvQgfoQ53oOZG/vhEee+/1iN8LYC1gCaFidhA2ZxYrAuOcfyRvoAqrQ7gf4qBKWbjdjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHEmk25anwLKXF8XyjhGevkoC00e/jHhf0W1mqEBMig=;
 b=ld517LjjOJTpQ+Cjf/fQbA/tpSKU+MPLBF0pPHOkxIht1P9nEzIpE21rga//gcmQnhYH2x/IiAGI/s+FEj4QMaZt+ThRRhD79nF+AWOtdJj9usUDzrHQlhBQ8B1hTQAmou1VDIVBiATsTy29VCr+sPo12fx2S2ILhZHivHATcFk=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4938.namprd10.prod.outlook.com (2603:10b6:610:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 20:11:28 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 20:11:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] nfsd: NFSv3 should allow zero length writes
Thread-Topic: [PATCH v2 06/10] nfsd: NFSv3 should allow zero length writes
Thread-Index: AQHX9HoH/q0FBtAROkub7IvP/pGPwKw6QECA
Date:   Sun, 19 Dec 2021 20:11:28 +0000
Message-ID: <26FE2634-B4BC-4E90-AE2D-9B37A2F4D8B2@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-7-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ab3a40a-8bbe-42b5-b83e-08d9c32bbdbc
x-ms-traffictypediagnostic: CH0PR10MB4938:EE_
x-microsoft-antispam-prvs: <CH0PR10MB493819D235BA78B381853E13937A9@CH0PR10MB4938.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FhS+/l10X3gNg+736bfh+wOthwtM3H5eyvbcnGeR3N5GcYjxEggdBiJ+lxMSmxUvJSWTTwU9hQMicg3iZY8Wh7Kk5VY2t1sDp0p+NNr4iQAGruGWXU0wqCAF7rGiOprk/cOKmVJyi9Lv/+UPQ7rjUWCUobDlAPpURWf6ejs7ElifOsDgyLJX313TNSHO8t5wuxI6xUMSHsYccJacbUHTceq29vvCgaZTcolK11G3obJhC/5S42kHk7Jhg2GZJld/y2HYfVFOUI+BDk182MQWEiCp+MfxsBOMNyJXXZaIaOgctkecwtxkHZHurq9b9nrKj1S/KwPjdQYseWFGTi36DkUGJojx+E4AXQ35YYN4K6Lo9NEGngIYRceJsv/Z4SJFCCBxNbZwh88XKtxNgIOWhdaZpV2TciSAqdZ3tgfnlPMYSkqpUlmrfdDGBCzN+5CrvPSuXbiJCGfT1jJzXH/zEppwKAhiblJpxx+fBoZ8B2Kx+SbOSPIMJSIHXT+B6Tbss9eDYlg09Sk9I9SzyEFvXgYPqsmYXFG/vtODendVd/emmf6r1pNP3uY0yip793aotjGN0VUVMNr1fh2UNQB4m0KNjukeo853nUqkmT4qWUE/QP1QJ8nEoO6YDPBfy9oNQAEF4dx++SZk0Qrj1PV4NmPtVkWGU27qlaGlBalPj7aEG9HSvzA0/2mOnKoUY04kDap5JbKnltvj0kD06XfMB9jvS+aYD5XRQitfD//Gdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(6512007)(8676002)(54906003)(186003)(6486002)(26005)(53546011)(5660300002)(4326008)(38100700002)(66446008)(66556008)(64756008)(66946007)(66476007)(71200400001)(76116006)(8936002)(2616005)(122000001)(6506007)(316002)(36756003)(86362001)(2906002)(6916009)(33656002)(83380400001)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ky2XR3f0KB3rkyv3HTJD3yPs9Gl1SErBZ1BaknqDsouGYsejJYlyUDqVNY8F?=
 =?us-ascii?Q?W/cNWC+WUfXYA72jhSyhw6w1PFzermTeNkh4AgdBZPJTT6CbqYhPo7K3/Vso?=
 =?us-ascii?Q?OD7uPV+3jjY9of6ClV2POmYlj3/rwPUK3nlCXMyGf3n05oswe/O/ofUvvOjc?=
 =?us-ascii?Q?j/KUQeMe6QPftfnUibBnEBXa5vDCwvptlFIrViTPLXZ056ajJ6JxQ/SvaRG9?=
 =?us-ascii?Q?ntTBYFjzWJl068S1D20hHXMBBt6XKdQmjJUriszAJ0Fmh4Cudx9filexexjv?=
 =?us-ascii?Q?ZOCtpJmoc7Yrnb3VpMLVHKiyLeEEDn/I+Mo03Enu1lOHl+Wd2nRqSUxDGC8/?=
 =?us-ascii?Q?OHWODwvSJtnBDs/ucRRTEHNOtpBwKrphGYeVoJRGapkS6jqAD4ijSD4hdc+A?=
 =?us-ascii?Q?j9lgo9G1S5Mi4jlgSEiFz2CC7l9spJIQmdUGTwG8k7fRStt5+BVG6ZHqpwTC?=
 =?us-ascii?Q?hAy7ghEYaAytRjuTrwleBAmk+VdV+wo1rmiKbnmrSZuiUUQV4viF4OiJDD89?=
 =?us-ascii?Q?9+wSHVFk8oZa27WPgbXUgli+iDHhCK62I5QJSVSdbvZe7lNe6M8CXhAN4x/p?=
 =?us-ascii?Q?R4oTy3SC0SHGaUmLrzg/Jt7Ju+kp0qxNENad4XLsWUC4XFwca+9m/AepX4PE?=
 =?us-ascii?Q?YH/BaY7iNjxTgHBfxNEPEOA8cv8PZNokqtuTAP78FnCFXq5dfeBHqCziJtOY?=
 =?us-ascii?Q?I9JGDx9BOR0SjOt2nDoflikdO+T/Z3MUX/tubANcgJA17dl+4Xo38+TPCubc?=
 =?us-ascii?Q?SfatnGUrD9pulnzqUXI/VHX8qhFUMRITCZfUTXWDwlVgBeKFlSutI45pCqt0?=
 =?us-ascii?Q?eXU9PCIEMgopxT6r4G3soXEz5W//DWx7kxjTguzWMk+pMn/M/qt1+CRJYAah?=
 =?us-ascii?Q?Hx7nF37qu3PalBVrfTSnv0I7ibV6+mdONdaexONUWEo+PC50fh87KsfIEZR3?=
 =?us-ascii?Q?0y1HtwrWoQBCLv4QkWJRcxuj+rji9189eFQOexaNDkmjJly6rLBY4KvaS202?=
 =?us-ascii?Q?1cXpR4xPE8ihZTB6q2wKrrw1q3Eo8tPJxdiMxEnHgkC0JIhS2ZvBiQMstXqO?=
 =?us-ascii?Q?VCLwuhyOh8SA3jcfKitvWeRoxdamfhqVbdAw1ZtFVGEuO//eJ9SHRuCDJwr9?=
 =?us-ascii?Q?2VYGmshsJCH6EfdrQogsHl+zbL88fsvzccO0mihdOEyeh9Zt26wMuUC7cNS4?=
 =?us-ascii?Q?U2+MBSMnPTKKAZdJQpl3ZfSBspR4RkXkybLxwoBbAFyGEuU8l8+VF23pMz44?=
 =?us-ascii?Q?X2C+8j8+v7oqol6aMJhXw1WVp4J3OIP0PltrL3byCV+RXAyS22zy0QG2C0is?=
 =?us-ascii?Q?QatWoGttNMJLz1E9khdzkt1hCYv7bMjnLC0GaUb2n01Lhrq5tes+fvFwpagH?=
 =?us-ascii?Q?UoCI1skng6WWd1xERwtK6bY81cnB3KnUKSmdI6uzhVPh5qK7k8t6pejjAQox?=
 =?us-ascii?Q?G5Mj6w7tkDk/1Vr00ZlADFfKgyrLcLQrYyiqFSGpPuAQc82WNs0zkfc8AYVa?=
 =?us-ascii?Q?OIMz5NPJ7I1w+UCogjK6SxCN5DBfn2Q3JjRrJC5bWBxSxXJD05WcHB7hGvkt?=
 =?us-ascii?Q?qfkFYrrubXKkqbgYkqDQGmuW1vL1EgUMwfYkAogXTcbYOzWHMqRRPZQRoMVm?=
 =?us-ascii?Q?ot7g3UCMV80ITYgpgQ04DKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C73873D622D8C84E988C6F5B2488A2CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab3a40a-8bbe-42b5-b83e-08d9c32bbdbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 20:11:28.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkLtWFhpzWmLGLer1XSecdEdYhHQQK6LUuWiQYkbhM2FQa+Nz4Gerz5Jo1lHldyv2+Q0VLuYRRE97Pc7U0d0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4938
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=790 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112190128
X-Proofpoint-GUID: hZNkNpBxezA0QCS4m5IwuH7i8J92qQK5
X-Proofpoint-ORIG-GUID: hZNkNpBxezA0QCS4m5IwuH7i8J92qQK5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2021, at 8:37 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> According to RFC1813: "If count is 0, the WRITE will succeed
> and return a count of 0, barring errors due to permissions checking."

If you resend this series, please move this patch to the front.


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/vfs.c    | 3 +++
> net/sunrpc/svc.c | 2 +-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index eb9818432149..85e579aa6944 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -967,6 +967,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp, struct nfsd_file *nf,
>=20
> 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
>=20
> +	if (!*cnt)
> +		return nfs_ok;
> +
> 	if (sb->s_export_op)
> 		exp_op_flags =3D sb->s_export_op->flags;
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 4292278a9552..72a7822fd257 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1638,7 +1638,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst =
*rqstp,
> 	 * entirely in rq_arg.pages. In this case, @first is empty.
> 	 */
> 	i =3D 0;
> -	if (first->iov_len) {
> +	if (first->iov_len || !total) {
> 		vec[i].iov_base =3D first->iov_base;
> 		vec[i].iov_len =3D min_t(size_t, total, first->iov_len);
> 		total -=3D vec[i].iov_len;
> --=20
> 2.33.1
>=20

--
Chuck Lever



