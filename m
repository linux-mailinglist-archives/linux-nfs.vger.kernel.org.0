Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6E62C2AB
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKPPeh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 10:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiKPPef (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 10:34:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C2AFCF2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 07:34:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGF4NcZ004650;
        Wed, 16 Nov 2022 15:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k6L+ijKzmQAixjfanIFHoHU4dtepS1yd3iHUNpJs060=;
 b=Pq+Sg6LVnQ3AE2ZdOn2jLuAK47AglwcRwZjJVcDEZIvqeeknVElP8+wK4K1EVo/ELOft
 0HixEgoh2I0UIAcKwBkt5GXvcEHqPNNSxs75xDEBaj575rHHek1vswOYGxxq7vY+hzb3
 0jdsnGyXQ7ew1v1CB8oqeXNB1vsmW85HS4+/iL6XdJg+jp9z4+uI1U+pykh2NGEYZwI9
 Qi7q+0Dkre2nyE0iW6hwLH7gPZ8lEpuUvyX2fn29sNSWT0BrU+SpIlGRCUMF9f6B21Ve
 W2V6SGWdgcuSx8nrz8jDUWsljnds2uecdE4yYsnBbQt67FO0X/yHGOEiwBSwFWam4Izc KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jsn96y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 15:34:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGFXsHA027063;
        Wed, 16 Nov 2022 15:34:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x7hrk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 15:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3E0x/E2Gs9Gk4SOl4T3/tIBV1fs0ay+0vVKMJ86Tbj+MRvfqArAaKhOtLcX0afhldsE7RYUWbq/VuCiDooeE/Ldap3UoreJah9XEomjtlN+CD4sxIN0QczHP9bC7dRTLvaaffHYW7SjyMe4xiSZCWv0Wop3h9qqKC55GSQZTLF9DyQD8Ee5qbEJOMQakvd96YVOepoQoZ5geEYWUsHGjZIBuKvbWSm9IDR2wwmEjw5Egbro6NVryEWpBOsHAdVltHRkMwO8j9nc1bnfwLz9WqmTLVzGsiKkiTy+IvT3uEpWlwmwivYpbiUyyvTG0ABm4SB1kJ8SBo8PaiD38A6yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6L+ijKzmQAixjfanIFHoHU4dtepS1yd3iHUNpJs060=;
 b=IdRNBeAcYUjkzdOrnuoJXXZcCVtyT1ha0HNwkIGPp72MX+teQfGda8Uw8T6JGeVyOeCe9g/a7vC2BMYTCiNfQUCT3eaAv8kMIdTEfNIwG9eu5Cmy3uo2E1ZCoqoLYSyATc5Zl/SNPq7Y8dd/E7I0afO8dCSTIfg2d9dasqil8er0VTfre9PelpE2xBWR+1FA5wgy1wjKQWORqHbcQ2KdE92ArJ85KaheHqRmYFpTg4VESXhh4m6ZC2iIRAZGJZ7eFnPCFCAApJR0zqQw7wH9X4LhH+8up92j5wykdj8Pf/CBhqQnqpyMxKoNfP9cU9N4sWCsZ5yTIsmplQ9Y32OOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6L+ijKzmQAixjfanIFHoHU4dtepS1yd3iHUNpJs060=;
 b=nJw+7PaHnL+kONC786Ca8FcvJZKOPvRABdCAUv6v3Tt5pqYBhrLn2WBfux3f5zjAyMKRaJLSMWxEDiKygCE3Qppp5tNCkJs42AF8fajijS254UDxtqX745sV7NF6B/vg9WQEk0blb6c+YVKrjyvJGBPDFwYyFHv29WiD2ntrDQg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4663.namprd10.prod.outlook.com (2603:10b6:510:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 15:34:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 15:34:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <aglo@umich.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of
 count
Thread-Topic: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of
 count
Thread-Index: AQHY+dA99BTueKkoaUW8ZOhqLPsIj65BriOA
Date:   Wed, 16 Nov 2022 15:34:16 +0000
Message-ID: <87A52A9B-83F7-4FE6-8ED1-E710BAFF84B5@oracle.com>
References: <20221116152836.3071683-1-bfoster@redhat.com>
In-Reply-To: <20221116152836.3071683-1-bfoster@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4663:EE_
x-ms-office365-filtering-correlation-id: cc3c51ab-8927-4f87-25c4-08dac7e80586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNuMYL5D1OzLre+UQG8wyVZVrnLvNXqtWgnp+RNf7hiiJ1vuf+MAWvyJEypyrOYb9H/zWAAUHrQR30/D0L5aj0RppmpDi70dz4m3jePj/iDbDsjiEG5PdtoRhphfc19r94dF6vrYTaEGu7KjQ5BulptiveqCsVOyOkjAn2qJdTpA0EPcfLb3NIPHfJVSV2Ntbwzxctw+zx8v+tu3nx8fcKY3wM/XkDkCrIzUb+GRRrSDvcs/oCSqL7ByttsnEkNZfY9erpndwSxOCEsXZ5CTdm4n/DPjdQ8E8aU/XwqWtOdd2Z4S/UPlpKTxcKS9g4Q6w6PUUhbgsMXrjfJ07NCn15+BKSInAyqBE44OokyusljoAC8DAusQEa8DElUdehImLemptWYaluruXUYno7z7iugoH9y94oMyDs33CAIAmRUDGdVshKlhdyKg6HnYnTEe8/JT3DFTV3s38AlJA0GIW3GgDD65Ks3lYeo567Q19NRm+I2HQHwSgCVwvmbBtUcSDvGXjJM3xnNFeF9EHUrSFRu8tol99bp1bUf5o0RlLpFJunAtH49V3cHEzekle95FXkf6l+rWYHstKqcj/omRAOMt7uJOvUcW4sVTsR1vKzjSG+Xs7VF8mzNlBYVrFqJsSQg5mxYUn1N5BpL8oPZkmCZFos3oILNtLSF5y8nYzx4o8soc/HE9BtxVwGK4UvsKrjLkR9bB7Pv8hj/yWObqbD75uhf0/3S/eIb55tYi8A80PuNn08mRggHtdZg+m2cikpoSnauKCeQzLp+wZ7gd0slqhLBpez7aPFaOcH0W0AI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(4326008)(38100700002)(5660300002)(38070700005)(2906002)(8936002)(122000001)(53546011)(76116006)(8676002)(64756008)(66476007)(91956017)(66556008)(66446008)(41300700001)(66946007)(83380400001)(36756003)(186003)(6512007)(6506007)(26005)(86362001)(2616005)(71200400001)(316002)(478600001)(110136005)(54906003)(6486002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wB6lLodV/zQLjZHGGwPu+xABPDSnXhLnBs1qbG68kTUNNXhThAl9iGEobyVx?=
 =?us-ascii?Q?OnbuTh5ug5raXF19NwV6L2Bo9wadyLvWBQryjLhkiXSPxFss+4dOctR/Yf/Y?=
 =?us-ascii?Q?rBNCm3ajcmBS8x/CJhWrGEnBeKQB2aIhlNBKybyTrUF27+ZnJ0HGCxnIaVbc?=
 =?us-ascii?Q?Avt6H0J5GasBKdCBI4II38KuMHf0yQqsScsvxXsdxyU9SQMkEpARbkNjZkt0?=
 =?us-ascii?Q?lbpc0F8d1SS4vU4Nae1LE5NK7kiXWv1CuTfiVHE5ni68Nfkiv+/ji4p+MMsl?=
 =?us-ascii?Q?B56NK3Qkqn8I6VJq3M8W2YSQTnEtNtWSXYQmGHUIGYjFHMZCUPH0n3PvqdQ5?=
 =?us-ascii?Q?GF3qZ1YMZ5HFDOrD8HO/Sm2ZXZd2Mr0GssyI1UW5Cl2PfKqT7O3FTe1hbC78?=
 =?us-ascii?Q?F5tBkPGrS4Mc/4CIrq9FPgYmQmCnnOEmoSHtMFQsAHeCXSDVCk7+d6fhdetT?=
 =?us-ascii?Q?zLpvjqnMvm11vRX5a3bEatdHHCHALK3WWO5Q1PcW1SvXcqW10bNanQfffiNl?=
 =?us-ascii?Q?yZgk2sKdOBoOxgI7BJaGWt9pE4R11TaVDE2/ObbytGJ/Tbd5rG+4JGzAV7FO?=
 =?us-ascii?Q?odm7A4fZDRhRmvbq4bMY80IdCmrHj8Kd5Wb9VChkIUMeGsmXbo0eCy/r/w/Y?=
 =?us-ascii?Q?woz8Rjdq0F8+sUc7Oq0+PMpivmQlnzJK8L6qIkm8HSpstToilz0zOlfmJa8o?=
 =?us-ascii?Q?XdGndPXYDdday87DAwsaX7YLHFBpEI6C2nxDWOrUgeiJc9ws/n4Wjcd+myZt?=
 =?us-ascii?Q?2xf3LrSl/oXCXviS1p1J367iGuR7lduYP4VKh8RfuVlPUiyCYcKJnVjsLVgY?=
 =?us-ascii?Q?TpA7pohY53PLiZMngLkkmnvanf4hZh7+/HvXA4LZd1bw+yXvfzz9Tk7/rvGn?=
 =?us-ascii?Q?C620Ux1lzehy+2BaTUxC+0oA71g8+fAbmrXlDEpZY0vDqxKzZR+grVrXOG1D?=
 =?us-ascii?Q?sNtCK6Rj470OITIQWDBEndcClOZZn4bcD8Jo+E/XvsB3m4o7BNz9pm4JDuyx?=
 =?us-ascii?Q?BeoXgxOXqeKq1N6jxK/i4Y2sHCjh05ipRNvwPRbUOM++uQ5YkQB+fYCrAQdQ?=
 =?us-ascii?Q?jJUCv7tj0uuG1adjsx3qZNiWskYdFgwuz1ffru7HH7FAzXK2wlbnFp43gdip?=
 =?us-ascii?Q?H8zeHvFBsHwVy56/h10FPFZKUzg+GsYiR5x6f4SBDiQToFxi8zTjvGgpvww1?=
 =?us-ascii?Q?cuxws3XRW/BASBsK02yrcwty382aOHwC/6kwMSeafJMRbZRo+YVmdxjasVBz?=
 =?us-ascii?Q?0T5X3oEscbCmJDEB/LEuML2pHH+kU7GV/nClVGAsGztE7t9R0mFP1kfRisPb?=
 =?us-ascii?Q?wjHbto2I3kxyJKmyBTXgnAvSv5a3DVQR+P+Nlt1Gst4a3JyGzw/V1kL8vcE9?=
 =?us-ascii?Q?R23GuccV5LUbOoDRgEdpWJS1niGpme9ihk2aKdhg/mxX7QUvI6Fuk7gujCv6?=
 =?us-ascii?Q?TjGrZfwJylAS5q43IUPKUcMcrk5J3mA72Y6HXZskGIHwW8rzqFg09mB/T2Id?=
 =?us-ascii?Q?Lo0tKPZrQouiN1+I4GFaoeh3OKLS34oX3rvgCw33CV0e3gJElWnJ8sKyfTrb?=
 =?us-ascii?Q?x9+olSaZCFnwh1WlguEdY2CgCwMXIEDVOvu8keJTBYZUGoxAgBWSFndEcqCR?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F99D53267A2FA34C94C2E13148864605@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +lic2oUZGYxoWEkuBOijWLkOvwfmZdpCYqfK5+b4cez2RFYy4U2+/8L2/qoNzTcMgkhJM1SpU6JO700sJThlosRoceD8/AgCa4AzkkzvPAdpLyy0vX8YBwvBjTBQmtu7MIjT2JqVtQ6zM6/e8YzYlkE4fM53p+dN3Cc1g5m43r1FRfzvBjKj0mluWHLuJARxpqKbd6HzxNd+U3Szy2kQ8HlTbmXIB4jPzWfZ4u9BanVRltrSp78wPYR3RWufp7oL9C42u1rNQDcMx8sOOmw2ZtZPHn42dtWPhFSVn3KTA0iK+mz28YZv2Hn0ZJw46U4f6ut15UtK5VDv/JOta8C/7mbxopJsb6xZZoNG1c+wztnpK2Qo4SCIqzCxmYZF+Q3mRszk+KAZvDM8xe6mGu+KqvHAQ4utHkIWZXduAau2dgSehV3yVkKeSrS9WitVFPeVcAM3RrEj8rEnP2nFEnqZXCRnQyTIj9MqLhgIrbMrPZMAW1xQaG+ZO2Hs8IIXQderYRoNkAsN/OFG6bevD+FbhBX2A7CJD+CSLXy6mpKIHqj0kDbjpwgxFZj2QS+Pv1MEdXgRTxLTE6DZhrOAnDKHc2MAchBief+xPXnq0NRnuFDk1rGwh8KdKYZzVeHthCBG82JeNjSi6eTPnYuPjG2xqhglXwr6WtvZRzxk6VVkevsu+hP5nSxaH/rptrrxngHCZ0NUuSgWPwFiIhNvWCifMG8gIc7JPWPfRApxtBU4Cn02ihdTO2w7JGmKwhPUlA737udQ9pcyHrkkrCLxXp3fwpbjuO+6O3oGgxzS/KOvDsgGjY0MsedyhnxD0A9F4Wnu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3c51ab-8927-4f87-25c4-08dac7e80586
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 15:34:16.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbsln9MTeciJFIR6YVXfBrtkcwjGPZn0HEVERt2NFzBYxYOXPETz7BFYOQGuzjNrMtTX+Etdh6AQSHurkjddsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160108
X-Proofpoint-ORIG-GUID: KDB86ltdJ4hFKO4q0isqI07TLt9cHkle
X-Proofpoint-GUID: KDB86ltdJ4hFKO4q0isqI07TLt9cHkle
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2022, at 10:28 AM, Brian Foster <bfoster@redhat.com> wrote:
>=20
> _nfsd_copy_file_range() calls vfs_fsync_range() with an offset and
> count (bytes written), but the former wants the start and end bytes
> of the range to sync. Fix it up.
>=20
> Fixes: eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>=20
> Hi all,
>=20
> This is just a quick drive-by patch from scanning through various flush
> callers for something unrelated. It looked like this instance passes a
> count instead of the end offset and it was easy enough to throw up a
> patch. Compile tested only, feel free to toss it if I've just missed
> something, etc. etc.

Dai, Olga, can you review this, and one of you test it?


> Brian
>=20
> fs/nfsd/nfs4proc.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..3c67d4cb1eba 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1644,6 +1644,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_c=
opy *copy,
> 	u64 src_pos =3D copy->cp_src_pos;
> 	u64 dst_pos =3D copy->cp_dst_pos;
> 	int status;
> +	loff_t end;
>=20
> 	/* See RFC 7862 p.67: */
> 	if (bytes_total =3D=3D 0)
> @@ -1663,8 +1664,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_c=
opy *copy,
> 	/* for a non-zero asynchronous copy do a commit of data */
> 	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
> 		since =3D READ_ONCE(dst->f_wb_err);
> -		status =3D vfs_fsync_range(dst, copy->cp_dst_pos,
> -					 copy->cp_res.wr_bytes_written, 0);
> +		end =3D copy->cp_dst_pos + copy->cp_res.wr_bytes_written - 1;
> +		status =3D vfs_fsync_range(dst, copy->cp_dst_pos, end, 0);
> 		if (!status)
> 			status =3D filemap_check_wb_err(dst->f_mapping, since);
> 		if (!status)
> --=20
> 2.37.3
>=20

--
Chuck Lever



