Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4621C64B998
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiLMQ0O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiLMQ0N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 11:26:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3D2BCE
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 08:26:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDGEDhG020582;
        Tue, 13 Dec 2022 16:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NJUT37MR7QZ+b/AwD5bBQ49lXsF516Mrkj7cEKLzdpo=;
 b=ZkZS5Nwm7DNf65ARtXR2+IEllU1wf0CmSJpzWvBHi39uGLF+nT9egK5lqUELtK1zR4F1
 9oZZu58B4FdbjsOuvskhST3h0YLrcuMGc9jGCabNVwDJvGk5LLDsT5F+OrAtfBiOJ1fx
 jD+GnVWlTBXpD/kPwon4IUO7lpDKxmrJq93uDYC8E3TEm7cJNJyP4CmWsAyRTKsCZ+vx
 hTUUxm9NCTuzUd4QkYE7mxsiG0f1WPagDqk8E4rx5BcJEYo+rPltjdMYl/NwLDfHp5ls
 FuOOl8j4fYjqETwSVNuFM6wdBY2Kmo546kUTfkP6okGP+mh9SEz4ReUZX51nHOyfHQdG 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcjnswrfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 16:25:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDFCRTa009445;
        Tue, 13 Dec 2022 16:25:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj61a7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 16:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3ugXVpk+Tqbcn0hrhwB46LLTqhkxzZqJrl+5dvixd2W9FAZJDYAbQvmEtq65BfqNKjYLonWTQVkX/CQPXg0Pn8SkVwbKW8YrBgpA5AtmdfxRisJd9X8yf+99UqnY92cIUDOQk002J6Q9lKcFGlm+VwZXIwucT4tXGbmO0gGQFE8LKhfqxwwemu5P2OZ0C4qt3iyll+PUFtdfOmEcOxCUzHnIlV7Ilqp/ELm+dAfAKJYBJ0p8n5DG+glEsM8GvyO0JDmLIgsfcm1/dYIiyS7fdiTXOrzsyMdD7qe6hDFBdMvYsHu04gB7CbIqCNBNv27dqL5D/LR1YLw1sb7MuOwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJUT37MR7QZ+b/AwD5bBQ49lXsF516Mrkj7cEKLzdpo=;
 b=Bv/M9IwtB0l6FvhCBIwnikLaGUqAk+V745e+H4j+gWg61P7umSpH5HfG1lZqDnvLRX5aHS5E3hYoepIAxK2roAtZdRKBKPPRjyEbxEvIifeUi5GLyyXpvIC3Zvvja+y2sfcgHRkqWR5BegPeyTGYQFkLXwvXnRlLf8PMRLKaKF9d4e4/B1DuotRbU+0N1LD6mes08fMDvYRvMhEbOzKiyQetGhIQc/jX0e8LAMp6ED7SsZOLY0hRrCQtaak2lZiH4ZDAzy8N4wPNePbsI1GwnO6cUsVs9DyKL5acgyxGY2Ow7C40x0O9swL3dn18Ff4BZk9NIGwCfSkKB1588KTTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJUT37MR7QZ+b/AwD5bBQ49lXsF516Mrkj7cEKLzdpo=;
 b=ZxGGZ+hfbe9FvSxfL9GO6dLf+Rg0xW2KNnuYJhEPCtCxE/dQXyyDlm5A/Rge3lSiB3U4RCB8LeNkLAMa4WmCcsuGJ8V2xap9/grH3d3rqdTFnjhdnxvrg3YoYe6dLPq1y4ontHqA0tD2kGo77oKj6zl5ijSMHbQOtD3ERjaANEQ=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by BL3PR10MB6020.namprd10.prod.outlook.com (2603:10b6:208:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 16:25:56 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 16:25:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        JianHong Yin <jiyin@redhat.com>
Subject: Re: [nfs-utils PATCH] Don't allow junction tests to trigger
 automounts
Thread-Topic: [nfs-utils PATCH] Don't allow junction tests to trigger
 automounts
Thread-Index: AQHZDwwkTu8unohjIEOexFngMQQ3nK5sAQ4A
Date:   Tue, 13 Dec 2022 16:25:56 +0000
Message-ID: <52DA8A58-FF23-4528-B094-D8849D1DE54A@oracle.com>
References: <20221213160104.198237-1-jlayton@kernel.org>
In-Reply-To: <20221213160104.198237-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|BL3PR10MB6020:EE_
x-ms-office365-filtering-correlation-id: 8855d9b1-8fd9-445c-6318-08dadd26b691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+Nf+o8MwGgZfRr6TS+U5n7hzRVB3IAxREkIGjWzZit+CNFeUtOFMwIGx4L6Bmi4Mnm9pTU+7KbndKc8tQoOV/vb1hbAQS9O8E43lo/yaXygAGCZ3Sd+m58+7mWFz5iGx5vI3901kFaZ8cHYEK5SmWSYb7La1Z636lDxhqVT3fPl99gnDqKa30kCnWdhGlnOiXCKaZHbHF08/HbTUMEk9WFIsm81Sa4ciwkE5Fn2ZVibR6qJL/gSh5ZJf2jaQq8SUyAkfFVGaVzsXrntJuyTiTEAZlU18Rq1aZG0GeBx1npJokh55U/DyB28SgKPvJBLnjrtiLGYvmlrgRIJq0DfScb4wtDNYVLljR2G3vbbFyy01gDDrnMcvZExL7tX+kE4hluwiAUai3/BZQX2nrGEy/Dp8r5/cWATB7kTVz15nmpqHHF80NhdtIAL7Rjz0gAMT97+pBz6qtAGh7F66ms7/w1AKNcbSosVDMfLTfdISJ8zhFNknbiob6ZSSAL6ddtkCDrxqsw1DDNIwAK5AI97BHOiro/XbsxIXA2Z2dvOzWzWiE/A9z3g/iJoOb/i60hFPdevhIasnz7iuh95xWwlemvsNmhGd5G1nSFSt6/PiN6BBBK8fjSwdohQS+ptZ6LMBw4OjpDDWqIt08bUpdNSIAoZB8wZwKLycv7TESyOlwgYufuftltbvyl62hG2UA2MZ4nfi/TFUoSzi0powowB3fpNlkk5pfErW1mDJoUHE1txmco7k+IwDfwf4V6lNr6SMRrIfjmwxFLoKab+ut+YAjlSv8jliOnLOzkxbk0pLGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(86362001)(83380400001)(33656002)(966005)(6506007)(316002)(6916009)(6486002)(6512007)(53546011)(26005)(186003)(478600001)(2616005)(71200400001)(41300700001)(2906002)(8936002)(5660300002)(38070700005)(66556008)(4326008)(66946007)(64756008)(66476007)(122000001)(8676002)(76116006)(66446008)(38100700002)(54906003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2+1jG1yfnDnlWEq7xp0tkV5QAMzBOyn/xx8QSgVFaMuZwqz4Xlxslq63OpXK?=
 =?us-ascii?Q?91sHNv0UO/GiN8d4e6xFK3xsiIEiA4qTIKdbrKBy+nLhIil4TcU4wLGdu+bk?=
 =?us-ascii?Q?VsjJi/lBPW+BWm3JokoBHEfvZ8h79I9kOidM14/1b7jTqu15OBwRt/F8yIJr?=
 =?us-ascii?Q?RAIla/341fSEzteqz5Icy8oFjSp0uCak7dPYe2Hm1i5eFuQ8JR4K5VRgIg8o?=
 =?us-ascii?Q?80mpu2gyE8UIbfagvuWZ5IL0bXJIV8DQzhe+71jpPdRTSV/f6Ctng0QXS4nT?=
 =?us-ascii?Q?mwD9A6l5Undj3SJhVvxilRDm/51h2j2S4uOMHk7VPdDfq3EDgVcXCbc6RpeK?=
 =?us-ascii?Q?WkyQLFS6Lh0jy4NzgfTUBQjkqxSazpmlKMIhR7Y5cCEDor5TEYCev0mKix+d?=
 =?us-ascii?Q?wJBJp8PkWX+XhrO1kDMAM0vRm40+NaVgWHOLvTrFBihOK80H3aW0NgaRjqtu?=
 =?us-ascii?Q?txkXElTBrAptHhzO6ujJPjQKhAU/Zjs7hlSwG5mJptaTbzqATanDLMVF2n1B?=
 =?us-ascii?Q?4sgO+cwOK/ogCSgdqfvOV4Ebtz8ZVad5KANCaqlwVXTDwlU6igi1jhsxJFfx?=
 =?us-ascii?Q?QGSKtyJFeVj0uI1eJHEX14C2Yk8bGMsbcxY1Um2vUz5y7TzYebdq1bxeUdC5?=
 =?us-ascii?Q?HefhtNcsREIEaUjE/8cGqvTxCQHI71pfysxCSWsCmxI3rK6AoGrTbRF0HJkQ?=
 =?us-ascii?Q?QKhC5OhDY4g+4dqjrzPlgGB61hwhzwKhHgXUqJIiVL7GSNBlV3+KTj3V/JZ2?=
 =?us-ascii?Q?5DnjntSCkB/yQe7cchxL7eqFbLGUT+TH4WYGw2mybbHnFjNxcMse/SMycE9+?=
 =?us-ascii?Q?qKzNtkgD7J82gKwgcOzVzxUhLL5Ef+MH46SF9e0tJe8U8e0rmvvbo8h/+KF8?=
 =?us-ascii?Q?lkbb6AUBsQTz/GqMrBFAOLtVgguoVkROHg1fgUT5VSww7IElEYDp8nnBl5rx?=
 =?us-ascii?Q?ZhtNRUdtwZH2JJF5Vfmp1XQAVwM0BWcfYS+8cZCJu/7kUhW/XhP2u+irzDLj?=
 =?us-ascii?Q?FoodTnDcn/KExP6q5PhMWgBNaG/zkre/rHrTi+zPdW2zy0Z1zDps1KS64EYl?=
 =?us-ascii?Q?P6O1tlpu7jWF7cKGy1HoVwBT0FQGtlnYDBXK1WRAL5cnJWQcicpXsP4+2tqh?=
 =?us-ascii?Q?4PN5Bf57tiowL98KdpgNYlV8nuqQ8Pr5uRW7rXX6YvNAjyHR6HKdSWYl/2Cr?=
 =?us-ascii?Q?xTmt0YO0KyvZ7XQbgnE8QhsfxZv5gzc3uyrI/wiAlsGL0hEDYfgdwRRjLvwx?=
 =?us-ascii?Q?R6/KzBw/5Q0KY/ADiXKE6TfT+ft4Lu/T45UmA6ND7Uf/4voxDQpSj0hfDW/t?=
 =?us-ascii?Q?TZXl8kIRGb66Dqt1b4qnxWcA4SF1UHgd7u2UFq9yZvhexVI4tiIzfy8qX3nx?=
 =?us-ascii?Q?QxsyiHBvXi5MaNBK7AZhqBu2NkVsG7KiqntJcgdFXeDRQovZje4vXP4w+wSI?=
 =?us-ascii?Q?D01Vzy1kHcdgbDgYGE6Gm1xiEs18aTeLrI4ag+KyN9XputEnxYVvji8XULoJ?=
 =?us-ascii?Q?5WK9eGGscBPZ016oZoXKz/L+Ovo1HqcaZWb9I9KDzzHZxNarmZo9P9vA4nlT?=
 =?us-ascii?Q?1bWQC2qVNfUEaPr2KlWFIUgwPNwHsUdigVs9TeDYSovPBwlhZI0RWM1G/CtE?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8020E515E350DB4281368E7EF5777B47@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8855d9b1-8fd9-445c-6318-08dadd26b691
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 16:25:56.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWyGHD72o/Jy6oyOer2i0SONkrTiyuXCBsTvk0dE/URbedxDpQFh4Dhvz+/31ggQHNcuF5EsEzNCAs4P1VJ0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130145
X-Proofpoint-GUID: B-XkKWpgAXS6f5nFfMUdeOgSIoi_7HtT
X-Proofpoint-ORIG-GUID: B-XkKWpgAXS6f5nFfMUdeOgSIoi_7HtT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 13, 2022, at 11:01 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> JianHong reported some strange behavior with automounts on an nfs server
> without an explicit pseudoroot. When clients issued a readdir in the
> pseudoroot, automounted directories that were not yet mounted would show
> up even if they weren't exported, though the clients wouldn't be able to
> do anything with them.
>=20
> The issue was that triggering the automount on a directory would cause
> the mountd upcall to time out, which would cause nfsd to include the
> automounted dentry in the readdir response. Eventually, the automount
> would work and report that it wasn't exported and subsequent attempts to
> access the dentry would (properly) fail.
>=20
> We never want mountd to trigger an automount. The kernel should do that
> if it wants to use it. Change the junction checks to do an O_PATH open
> and use fstatat with AT_NO_AUTOMOUNT.
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2148353

And also https://bugzilla.kernel.org/show_bug.cgi?id=3D216777 ?


> Reported-by: JianHong Yin <jiyin@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> support/junction/junction.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/support/junction/junction.c b/support/junction/junction.c
> index 41cce261cb52..0628bb0ffffb 100644
> --- a/support/junction/junction.c
> +++ b/support/junction/junction.c
> @@ -63,7 +63,7 @@ junction_open_path(const char *pathname, int *fd)
> 	if (pathname =3D=3D NULL || fd =3D=3D NULL)
> 		return FEDFS_ERR_INVAL;
>=20
> -	tmp =3D open(pathname, O_DIRECTORY);
> +	tmp =3D open(pathname, O_PATH|O_DIRECTORY);
> 	if (tmp =3D=3D -1) {
> 		switch (errno) {
> 		case EPERM:
> @@ -93,7 +93,7 @@ junction_is_directory(int fd, const char *path)
> {
> 	struct stat stb;
>=20
> -	if (fstat(fd, &stb) =3D=3D -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> 				__func__, path);
> 		return FEDFS_ERR_ACCESS;
> @@ -121,7 +121,7 @@ junction_is_sticky_bit_set(int fd, const char *path)
> {
> 	struct stat stb;
>=20
> -	if (fstat(fd, &stb) =3D=3D -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> 				__func__, path);
> 		return FEDFS_ERR_ACCESS;
> @@ -155,7 +155,7 @@ junction_set_sticky_bit(int fd, const char *path)
> {
> 	struct stat stb;
>=20
> -	if (fstat(fd, &stb) =3D=3D -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> 			__func__, path);
> 		return FEDFS_ERR_ACCESS;
> @@ -393,7 +393,7 @@ junction_get_mode(const char *pathname, mode_t *mode)
> 	if (retval !=3D FEDFS_OK)
> 		return retval;
>=20
> -	if (fstat(fd, &stb) =3D=3D -1) {
> +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> 			__func__, pathname);
> 		(void)close(fd);
> --=20
> 2.38.1
>=20

--
Chuck Lever



