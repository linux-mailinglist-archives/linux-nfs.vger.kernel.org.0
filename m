Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C862C89D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiKPTBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiKPTBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 14:01:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C35800A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 11:01:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGH3tOn025321;
        Wed, 16 Nov 2022 19:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o96GX6kk9CBDwZj3uEhlM/pjuHwU5eX5Ns4jKrk3jK4=;
 b=yQtK0NYnUJH2elB0LsAauyvt/DQlgDvRC+n0zZF83q3jrEYr8gnW0kUfe/SE12a+3akc
 A7ieWk+/LN51isyVP7Ek4i4QiQukfVb1lWN3cID5gkWXqboJIKFfbmS4vg2g1HK/EiDI
 sYP8J7Kf5Lyi9rTo2JTX7i161+zSEX95AFCkOWAhiGFBfX4EodOe0kk3e8vxxg9uNWw3
 hlLwRRQEPVhT0LHUlT7HHqiPpfx8Jg4I0IXPy+7i4DjEVD6Fdo8M83yFIQyIC1YMYC2p
 c+518phwz1nHmbEfJQIWu+Ww1QVwEMPxsEV2SDLSYOzUIRoUjNz5iaY22fv1N1kzIZBE Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n169gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 19:01:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGHsFm5040918;
        Wed, 16 Nov 2022 19:01:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k8qpav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 19:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVQzcVWihsAbzsBzsQybKENUcqyZadyfAnxf3rSGO/+rpwFa/+hWDOwuiq7ymnW3nsiktSW8pBVL22HH30UuA4XpcfH1p/0Yz87g2e0bfgrmwt7S8f2UahZxjYiCwXcq60Ah+0ZG8RueFKwYvb75iFl36rb+nD8ymUSI55X17AP420D/Hug7zxkBRXAYNHA0IGgpsSLLo/EPal+y3yIu86gd9RwfUYS0AQUUeBpLSdFOGnQ5RRDvVJWmzSJFDNOIOm9fGknVf2jDkFFQ9fg/mAc69bDDZbBNOMhYHqHbTyUj704z3OevS6hJQSdgxOoJp9lJ4YIENY/efkEQHWX12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o96GX6kk9CBDwZj3uEhlM/pjuHwU5eX5Ns4jKrk3jK4=;
 b=H/Rg9e8D8j0OtykC3YjaxHSLwbvNbydff1588GehX3TlnIA08KggDc++XUbGp9OkXProzSm2aZRd/lHJFReeNzpei+Z55xOLBBwsCurUttU3Wkc2Syd6t9DfWujZG0EBp0I9svNJqR50sN1Y26nzG7J/5AlR2Vzvo/bvbqRAAjtgGryPE/fXAxebnhcKosWaK5xSMC+BMZSmhVzyhh7rz8F40Wbfkqa3UeXgY07adS+IybJeO2uhiWTKTFIDbh2DwA3Ob17nJpfXlqLdMIE2vKCiGm6R0gMld4tkGPmtK86pS35XkWkklgLbkbLASUBdXykX1F1W0ESG4VRDCBTYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o96GX6kk9CBDwZj3uEhlM/pjuHwU5eX5Ns4jKrk3jK4=;
 b=XD+RHsvVE4jaG9c8rhOLXqhGQZTaVWZ2qE23U5glayhFGJIRCJRpGi/v/bHUcBlU2wbxtTowDMthFXUQzUku8n9PVZJCTwm+qtdMnj3NwF26lEFdFEHJccQ89NGDqt4B6lglyhNx9lIp+9yd6Iecspfa+u/Jxmd/QHt7AKlzMzo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:01:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 19:01:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of
 count
Thread-Topic: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of
 count
Thread-Index: AQHY+dA99BTueKkoaUW8ZOhqLPsIj65BriOAgAA28gCAAALlAA==
Date:   Wed, 16 Nov 2022 19:01:16 +0000
Message-ID: <F8A4FD38-41F4-4B03-99D9-7043CD3977FF@oracle.com>
References: <20221116152836.3071683-1-bfoster@redhat.com>
 <87A52A9B-83F7-4FE6-8ED1-E710BAFF84B5@oracle.com>
 <5163ae19-b78b-d047-f700-93b3ad651eea@oracle.com>
In-Reply-To: <5163ae19-b78b-d047-f700-93b3ad651eea@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6163:EE_
x-ms-office365-filtering-correlation-id: faed2fc1-8e74-47f5-04fb-08dac804f090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1hEf0VFK1WASJYKoriT6BdVZR4oEwkbBU8GQuMhSwfkU1dac2EMjHwHQhpXafvG/i0SxpFFgo4vU2Fw6m7xhkJn4FaLE0QuI0g2kPoxkiE0zvOR6zdnVNAdd9Ym542tam0Gkm4etzYW7qv1POUS3brpnMTpEYLZYdqeCkeQxSWIIbnj7eItCPSAA72vZWmfDG/jMFTeJTT5//5vLYMtqwHViH0YHExjo48RxzOOJ9f4SziCQaYZND2hlwdEyw5gsg7Vez1gqr4cprOBqzqPe4EMSA2XyycLSkqSvOwjDSy2QrrvLKzQMkHZMAHzfOTOcZ4QpPa8lxdnJLMKcIpfMsG5GQ35jBZJh/cgVT3hIspgW6eNhDIpaQSc7FgWn2StsKmpOReVaJYZ6wZYx8H/CIrjFALiXtghFJK4O+dRS2gN96VAp4iWydVa7TGh0gQFhg9fdxF76DfLltRuwES+Gy+Vzk0VOnwhOlUORtUUlwbzu455YDRy4LTDKGesuZ92RHS/YCnGPDhkG329lthWeKPC7GylGP1DFzBehmjcB7cFMCmk8w36yPxrf5jE/77gAN9zkOyYeWUy/hQFTNOpbpbyKPJFgvDGcws8g1iXZl66O9VV800AwKNIgW9pA1kjUudxV80YSn9jwTr820of2QTqYuRCiEnfSikqt+kxNHGnV/+xaijmnIpsNYJubVkxeiiPavBqUQliaKRAqI6f5+wV+1vV5OVCG1ZbTMxJPeEbhSOaf1t3qa7s9EPBlRcKv08RULEDZMYsjn5G3+VUc26oFRu6Phe2bfGbJXqOV3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(36756003)(5660300002)(41300700001)(8936002)(2616005)(6862004)(186003)(2906002)(66946007)(316002)(66556008)(8676002)(4326008)(26005)(91956017)(64756008)(6512007)(66446008)(66476007)(76116006)(38100700002)(86362001)(33656002)(83380400001)(122000001)(38070700005)(71200400001)(6636002)(6506007)(37006003)(53546011)(478600001)(6486002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUmZ6HmnuP/1vpBolONQiJjoagwWrRhBqHmcDr6okGoXFQJjrWHak6RP3abm?=
 =?us-ascii?Q?sfNxE3oH1Ese/v5PlHmkbO48ZkZIKRUD+imquG9IQpnpeShX12Ij1FGLO/g7?=
 =?us-ascii?Q?wwJ5bsOcLx7TUwANkfCjIFvrs/Aao8QBPZAfMliM/RLJ0gcQtL0QTzlLSPSs?=
 =?us-ascii?Q?UvHHkII7AA0a6zdmb9dlJtQdbxYW6NTt+PMHPBG8qelT8I/296ogcQMs9a5I?=
 =?us-ascii?Q?p425hFmtKNtu9YGvm90fN67mhb9ClAwpNWhoYF7J8EupRhG5/VpTXsqkGy/O?=
 =?us-ascii?Q?VOSwXAGPoLC6EJ78ueWuky4Z9PqHyavqRjCyQ8f/JBVhX5Gn2CvcbpGmm3tw?=
 =?us-ascii?Q?oWjZ2aFiWOkR52O32PhQRz8vUKq36lHb2oU6QeQXbFFv1YCp/Jj+2ewbnfwQ?=
 =?us-ascii?Q?ijGyqLvTXooROEq+wBZ7FY9y5YdwPLyReavuLh17quYcrrZHWUK05bgKl2vx?=
 =?us-ascii?Q?IjFIurmOIdGEdPl+cYvxeV7P779P7Ycu4TKBIcejRfqvOwziYugkTzJhSaMb?=
 =?us-ascii?Q?47wXMnthAREHRtcUfKW8kZYIEppRZ4LKMruhSltRhwAbNVx8LShuatMxbX+a?=
 =?us-ascii?Q?fTePKiZihQjur7uwndRef5sV9hYxtzeXmCvO+ALgvl+ul699JpsX6+cvyTmR?=
 =?us-ascii?Q?zgcKFOku72Fo/mW+aaPpAqX+FTzOM+v1MSbpYEsPOfOdrzf+8R/k7r/qAvjJ?=
 =?us-ascii?Q?xW/tu5yBIUFmj1Y7E3VWoDk9ELMulGzUffQbqPlZ9UDhaOCq+/3o38K0DHvw?=
 =?us-ascii?Q?e0mUNLYWn66amjPEe7/g84yqXC+XmfV+rBwrn4ahJhPsfUa/XHEuw/C6l39f?=
 =?us-ascii?Q?HgqZSMDbnYYc0/0qI8M/vAU9rW/stE9+pHt0wTumi+dbiLjwP7CuVWBlBQjO?=
 =?us-ascii?Q?mzJwvKjNmNRrbjaCG0NGOmUdbjz9CM3i/oxdsLAtRFVaLyilZMM+XZkZR9E7?=
 =?us-ascii?Q?Z1du/20gcqe/4WKfZaB8KrGM4hm2DlNoF8Zm7NcR7N0UOFc+NB52OysGv9SZ?=
 =?us-ascii?Q?i6AothdN8t3v4tng/NNo5AmazWlQKsiWEx0lTom8C5xZGsZy931o4CudRRXB?=
 =?us-ascii?Q?TEnKDxlEaOSVNMnIyQdS0D5bvvpy8JyIJy4Mq44mM6JCF1MMjxDeRtO9EF9z?=
 =?us-ascii?Q?/IjT3w3u/y6Zu3jt4jxiLcyNDK5SblZycX9MVV3MyEy+v2LBIbFdAjH9yOJ7?=
 =?us-ascii?Q?1IboK1hffvbS4P/U2ZwrNiN5GceVwP08sDvHbou8Q6qFozP5A91ipOPQvmPg?=
 =?us-ascii?Q?cSRbMr1wcYbOZPbuoiq7sS68HxKvRfoLvdOjpSCOVc+uwsZUqC7IvF4GVpv5?=
 =?us-ascii?Q?Lc/LfSYw/Q1PPIY/m1HuUaBAqIgjQ2suZNn4EM19dSk2rHnrZEYixR+6Q16A?=
 =?us-ascii?Q?kgtd0T9g8g0WvRXxMpCjOKKFdnnsDFH5eDNQNHEU9mq+gnkGYKe3+12kXocY?=
 =?us-ascii?Q?JNgOYRvFe+KswURf6zydEbrk6ScltQoOBFFD5fcshYwsT4a/9c2gIc0juC34?=
 =?us-ascii?Q?IzdLukrLVfps+NCqCT8gaV9hZymNxNcXZ2qhlgaHoIqgzo38vth4Pf5oJdw+?=
 =?us-ascii?Q?EaUfEg39LpNGwXZYYQi+dYWY7HOb/Lnjrz46wb+D/uYG8UjCGWwW1FJv9yHT?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52CC496E73C1744D80E439791A7EFA30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 87b88tRZzUQlv8m2NbKqzRLE8KreRSbLTNA4LJRdrvRvIokwxAZAAbaDH0pFdIvpt9iyv2mHV4/re1Ati+EKxIsf1zcn4+Swg/ASmbEB1Q4FfLhucAEju4ZyaAbXb5IIiZqkTwqRev8TFpuaGXF0W3PuTVda1/3f9ZmRRmNoIIKiofikBRomR4L4gKlaTVOd9AHGJVQXWeECK2KWJURZ4O4yRAcoPHuq7eyNilGQsA3Zzt8eNt6PH/qZ3lC8GWzQmFnjf6eHY9WgAWn+cjlZFOYO/b+kZdFDOVBO6JtY8FQ4Sug779ijcvNJfunOErGBv5/eqeSNSMKOIfSPW6ly4MyT48OKArgEMSRfkTIBWMjgCCvfWpJ/AwNLV1cCF5OjBstNGIH0HdX7FBRd4AI+/1DOz/1E25y9dDm2RrCI0qH9mSoO8ulbt8x/JA8sYRz1AqIFR9klCGBpLdNAsY607L0pZDw1I6+s/mQ1U3aJg/8ZxGSZca1Mvg8aiR+yALEvKqIQwjuzeqc0TSu/15TrwQyXFsC+r+hZtuSyOLkn2wEQjFQ/Pk5hO919MJJ1DEz6HcM/Qr552EOc4UmvcmpmAQXoeVlKsZt4cDneQJi85edMNF2pMJeVfcb33kC5v0+4b/aaBeA023T6xgQe/AyYDDWTCtU6setcJQOSfOay3rG03bPJxcSG6xrHJf/7Ako1oxqlx2FF4k1QSSZUtknsCC0jVdFGLaFumRxxXLO8rxjqKSMv+5DEtG9jPmbE/Abnym9Xv7JySCYVfiZ7xuEC9d3CEWQTcxuDa8MJ6XAObbVsdx734nBK71GyCZtpFC2F
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faed2fc1-8e74-47f5-04fb-08dac804f090
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 19:01:16.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DC6ByW/OFdLANJ+evfV/jOqwskvnCzHTo5b/7nfxl4GkF2zWUe5JL6LPtAh80YNh2W4FHjvYTXHM6TwVvFeo/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160131
X-Proofpoint-GUID: ufr48iD5Nb9ZrGsU6tWTUEoz1YqpTF2-
X-Proofpoint-ORIG-GUID: ufr48iD5Nb9ZrGsU6tWTUEoz1YqpTF2-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2022, at 1:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/16/22 7:34 AM, Chuck Lever III wrote:
>>=20
>>> On Nov 16, 2022, at 10:28 AM, Brian Foster <bfoster@redhat.com> wrote:
>>>=20
>>> _nfsd_copy_file_range() calls vfs_fsync_range() with an offset and
>>> count (bytes written), but the former wants the start and end bytes
>>> of the range to sync. Fix it up.
>>>=20
>>> Fixes: eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>>> ---
>>>=20
>>> Hi all,
>>>=20
>>> This is just a quick drive-by patch from scanning through various flush
>>> callers for something unrelated. It looked like this instance passes a
>>> count instead of the end offset and it was easy enough to throw up a
>>> patch. Compile tested only, feel free to toss it if I've just missed
>>> something, etc. etc.
>> Dai, Olga, can you review this, and one of you test it?
>=20
> LGTM, tested ok.

May I add Tested-by: Dai Ngo <dai.ngo@oracle.com> ?


> -Dai
>=20
>>=20
>>=20
>>> Brian
>>>=20
>>> fs/nfsd/nfs4proc.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 8beb2bc4c328..3c67d4cb1eba 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1644,6 +1644,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4=
_copy *copy,
>>> 	u64 src_pos =3D copy->cp_src_pos;
>>> 	u64 dst_pos =3D copy->cp_dst_pos;
>>> 	int status;
>>> +	loff_t end;
>>>=20
>>> 	/* See RFC 7862 p.67: */
>>> 	if (bytes_total =3D=3D 0)
>>> @@ -1663,8 +1664,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4=
_copy *copy,
>>> 	/* for a non-zero asynchronous copy do a commit of data */
>>> 	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
>>> 		since =3D READ_ONCE(dst->f_wb_err);
>>> -		status =3D vfs_fsync_range(dst, copy->cp_dst_pos,
>>> -					 copy->cp_res.wr_bytes_written, 0);
>>> +		end =3D copy->cp_dst_pos + copy->cp_res.wr_bytes_written - 1;
>>> +		status =3D vfs_fsync_range(dst, copy->cp_dst_pos, end, 0);
>>> 		if (!status)
>>> 			status =3D filemap_check_wb_err(dst->f_mapping, since);
>>> 		if (!status)
>>> --=20
>>> 2.37.3
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



