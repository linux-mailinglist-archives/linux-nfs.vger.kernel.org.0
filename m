Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9D672488
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjARRLs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjARRLr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:11:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F1C166F7
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:11:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IGDwLJ008342;
        Wed, 18 Jan 2023 17:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VuBhuBuF65bg27eM16PQPf2W6dLePVa3vVxPWAg7W1Y=;
 b=auck+Sfc9nAPlGqvSvY1m/Uyj5XgiCnakOt+vphiTvxzk269TUIsG+2uxdM2GEFW600U
 i55Dax6DvpFE/wtTWmgK1AqwSjf91pQHHJ2VSstEmO8dF0Ff0pw6p342EGcUDlEnlAfP
 kZepgcDE0mNSvFn/9CNFqO608IsMyFimYq8wFNk87W0qLZuXH3Bvxe5YN2QUSNoCryeR
 k+XtEAiFVXCdrhVUXOIpfMWfAd6vTzMa7R4g0GTrsxpaO5YQrLlv6MaAwYzZF2VQuajB
 GWQI6cMWaekRpR4Q3GnusrzqAFm4tNfMJwy/nj9M2gPSngBTxSl3hk8JPRYhnB8K7cCU OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdfjgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 17:11:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IGd2pC002066;
        Wed, 18 Jan 2023 17:11:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6mfqsfw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 17:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=augPYMZ9ftsE0JNz0HJAP8oY/cqH0/bPNeEBBne59J5G1VWNc47EPDGI4Ux5K9bxGWOZHp5zT5GAo9F+Xcl9kct7apCjeUFnrLA2bzrpjLJUKeUjZcFmV8WWhBLzpBEv7Tdr1Gajl9wnHwRaZiWn/KAaJDHM8lOmfqWLxJIgIRCO03CWVGgLn6CjdOaTkDAGlRFhYMnzB4UYviNauJNnQ04OSQLadyNH7wBktVLU2o4k6jGsR8O3to1ziE1UAUMHQuOATvd2SpiKvbNnjZcgjFYsV0KsVy17abN73MD8hUiUIcGXbguDqY4+/Q4mQ8yLnvu1wJcW6J0NLFzIL79d2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuBhuBuF65bg27eM16PQPf2W6dLePVa3vVxPWAg7W1Y=;
 b=TgcjFSgAJM6Z0OPR63nXN0mLq9tajabBT98t403jAlV4KBEJ0bIHDnxAGatexFYfBfPWDlqYH/Kekdw9/8jO1NPTqd7yITsri9PAWJKc8slixYnZ/h53G4k9HeqYZkzINKkYjPSdaCELP5n/wjxjFNBPR1h46SgR0P7GFvyXvNvU22R1+Hk0BxCV/WuMmVQr/WAJ2JqSrzktBN8/mg01Ccaea2ROvQVETAyawAJ+Lo0RDWf/xK1lnDaMr86aLFL/THU8GM+aemslzyr1EK4OSkorfeHfAbONEE5yig9leCxtg+VD6gVuegw/Byht4GEuFWb/66JvAUUvfia8Vf7NPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuBhuBuF65bg27eM16PQPf2W6dLePVa3vVxPWAg7W1Y=;
 b=o5TCXw57jMIYtZdU04cYKHy8Sj2qNcEVonHWAzo4O041rOvTcOyN/dCRmtYzPXp7qZUBuCKDDD1nR+B6FucMKBWRu/vGYZBsAaDSHPkaNalhixaZ9X5BqbH/SAY4VPFR7+mKTx8PKdVm3rmnSkoDDYxUFtqmRWb6i26ii7faajg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6303.namprd10.prod.outlook.com (2603:10b6:a03:477::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Wed, 18 Jan
 2023 17:11:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 17:11:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Topic: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Index: AQHZKqtMKSgqI33qoEK/JPELcgPtS66kQMuAgAAMmwCAABFIgIAAAtYAgAAHiACAAAFugA==
Date:   Wed, 18 Jan 2023 17:11:33 +0000
Message-ID: <DF04476E-D657-4CDA-A040-FF7FAA82ECE1@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
 <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
 <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
 <12C5F3B3-6DB1-4483-8160-A691EB464464@oracle.com>
 <0fbcbdc37e7e3f070b491848a74be348843074c2.camel@kernel.org>
In-Reply-To: <0fbcbdc37e7e3f070b491848a74be348843074c2.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6303:EE_
x-ms-office365-filtering-correlation-id: 187d9674-d4e0-4e8f-211c-08daf9770ce8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeeURxQI71kUPuo7anHYObQQi2GUq05nS7Cgp+iDxIl/cMLWuSGcncJ/h4AWbuESlWdv7CnRlm1dE/EhGpi5PqwtuTTmE5AWdmVbZ/OcfWv90YvlV5BOgQ2W+tI0ricpB8CwE4cZ9cfma6+XIsaI1nvpKQyJ15xbmzEO3Rzh15VhHKtcRKxrLRyXwdja/e6wQWjpcv5mOhaoHEInSwpLKoK1z8jCAxeVaUzIDXLENSkXfGOawyCrKz8a3BNinBF2g9IbR3YtJhhGiqeMalvwCR8nuS89NB/BEXQ+o8bSUKq5mKqxQWevfN/0dtjhFyndrxUlKD32PqJIQYdY+5kRsCDMJUHRKE70RCEbg30/a1kd4saF9y/xrK7FEJhqlSVEWSmqBcxoFTQILuYuS6IhIa2THNvRdE8hcjP63YA7AJkb1WQ+6BkemVAmnqC7RY2G4dkhpA60tAplV83PFbXdG6n70p6lkvNWI4xbFy8Z0dkIDI6mYs2O6elCeox96Xx1y/llxw6Qtmad12p3kQ5P/hhvLRIWPqyXeoeR+D4cb56y/3XphvxDSbdCHp6PeVYvvLNSiiN82ABg6IJnSqnu/MVn1sVsy1TKNtv5T7l6wbAf52qr57e/94zIWzaON2LgAxjT+LS/oep9XGQwR3XRXtqa5HNH63FFwJ9guHwvtUBLQTflFLQ5nvwmU5Kf5ZJNMlLb0GgdFSdbqKFTdSTDh56ZZdjs5u1JzBBYmS1bhto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(66476007)(38100700002)(122000001)(86362001)(33656002)(8936002)(5660300002)(2906002)(91956017)(76116006)(66946007)(66556008)(66446008)(64756008)(4326008)(8676002)(6916009)(41300700001)(2616005)(6512007)(186003)(26005)(53546011)(71200400001)(316002)(107886003)(54906003)(6506007)(38070700005)(6486002)(478600001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u+ps7RwGQBcpDN/UJztYak5yTpmcIVNFUzqB66itQxMkeoR6spdnAT9Jh+xt?=
 =?us-ascii?Q?wnHx01RRm15qvd73BVqSKadlGeS510kg1+SisoOZm4UMYS7guTwZLHzZRv9G?=
 =?us-ascii?Q?y0mTC0CzyAoGkqMwxS6GYqU1C5jpxLxv1wMPQwuR5QJwDghi8WShL//advRR?=
 =?us-ascii?Q?RjNtH2dZNr7H5j6c+M6tkCjGF2kXKXlOoY0z+13Fhm6W5IUxQxd1MDBZqJZC?=
 =?us-ascii?Q?s+3al0D7LImsosO9RZdXRjUkAHNx7dOSN2jICdthPfn8xNmzKykLoKNitDyR?=
 =?us-ascii?Q?mDRDUZ8zSd4YR8l5IkAZeFRMkMiespNrm4ZqU2dC0e+Ygs+l2ibDLlAWBWhE?=
 =?us-ascii?Q?SDTJ+BRZ8fxV94ZUM1jYUjTHyMIfFm63QGY0hGjfUkCKeM8xDojUhS/4WTn/?=
 =?us-ascii?Q?X8WswN/dzBCNUx+41fxFOFPJFhn1PRuexmy/cV9zOQDDa2O0GNBTbNxacK/J?=
 =?us-ascii?Q?9BebqkH8NaRxruAb5Eu0m9QMFLxzMjk/R5NjRQtxikRibsLk7Sr1cdLYDXb5?=
 =?us-ascii?Q?uDqPF1dngjLEz64yJ6q/7m6Iay9PnjPW60gAvX8Umcn9Nnm0kKejx6eOp1Wo?=
 =?us-ascii?Q?bDvyR3zbODUd9OHeey58NcKHhVXsXSne+332hqgyoRBXMBWF+xfpuCqVB3JK?=
 =?us-ascii?Q?lMT7F2F+LIEN7SYyOVvko6TTit51AEa5hqrMq6XDEBO2d8C8x9y5WbLuGUr+?=
 =?us-ascii?Q?TBTBVHCWkz0h5++KyFys0LslxPE70JMiXIzWrAuktgaHf601pyQFvztjVbBJ?=
 =?us-ascii?Q?tuEbo2TmD8z3UKDRtUWKhOC/I/i10Bcroega4iXYS8j2sV5fzqqKieK7gISQ?=
 =?us-ascii?Q?dheqP4iWYa4htWKSwUYGavAdJ2/3X/y3A7vEqpi42OPB8SUbxDZnqluQjJyC?=
 =?us-ascii?Q?VFf5I4U49rB80QvnWEYP+x0asu+yb3bYLdZLo8lvKMu+8BFgH5ixItMdfVQx?=
 =?us-ascii?Q?DSeir7SzELkJc7pTtL3bsiUEHqET5432Jv5HLN+jN5eMdIM8Vu21v9kz0/j3?=
 =?us-ascii?Q?V0AUvRttfNQfyn2JWnDX19Y4SzeweXhtFdFa7cT4ozROCFeUBvoqhXwQ0lFV?=
 =?us-ascii?Q?R9lPWAbpjrTsolEcRLf0FNYR3By2cveX6mrByTXyb4SulP3Bn3jZlt0sLQ3I?=
 =?us-ascii?Q?zKC224N90FqQCPeguOgzcdKMnkN+YfFX5cT/wmc9E/VSDS3XS59KeiVsbwIp?=
 =?us-ascii?Q?A76W6q6uvWUyQyjQ2Dl9gE2MqR5VJ+dt+kbmNQZLG4XexbQp0RsBdnQemFXg?=
 =?us-ascii?Q?84GHihYcSf7JlmrZGSwd1yUJOpLd4CVCCUFsbGmpopxDOQfvDETE9vqVrMCl?=
 =?us-ascii?Q?gTJ2shKbTsV/GDTWb+dglhRfieho+UEugr9ScmcLkI8cpcj2R4JPor7YMMEN?=
 =?us-ascii?Q?3pP2K5sUkj78L8GtwFBARgmukMm9Z821w8Tunt9QY6qXlQ4anJa1EQ6Ozci9?=
 =?us-ascii?Q?epYgc5+ACHADVFzNzU/aGQYCF+1gsb3OLBl09cEq89a0Klqzdk51Lzun/aO8?=
 =?us-ascii?Q?DpTCf9PF5OdhY3QaPHT1HS7G1JofynDehAnwSt6iWCeQO4S6YEjatNBl9lEN?=
 =?us-ascii?Q?gn9lWSO9u3QZlFbTB+US6g3LDrb2Fmluu81QigxIsYQU3joFM/VRg6UR0W7J?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2303EBAA8BE04641964E8DDBDA3F9CD9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H+sw6H9ckmeR4FvdXnoI6NNKx0Do/o7WN0/eucI2ovgjkDaN6qq+C760DrB0LHM1vxHJI/+/Ny/WIYjv2/kbWBQ8OAL7bwHfwMBPodB8yqP0EFyRkXFgFTtF0A4pCZk7ad0HRujBDCY57J/b4Jr2/ZSkNe+09b32amxX7EFaFunDQCU73YVPUTc9u2lDGXAS0BUgPxHDlVI0ddznIfKS6gl5u9rBLJTZ6HmgsZRrMFy8oOecG/zRzhtqDW/PDooQu+azdTsTNYnTGVHJ2axs9mBM8NLENs3E1nJ3eMqRB+RRpQcouBPzQtb4ZONIKxlUo/UjsntjGnoXb0744Ff5T8LRr/gTF4Gi/NOHCZDcXC1lDZb0SZwcIu/rXules9Zexdx5m3mwXJzPP95sV8jbMSYHgLjdsg0Wf2kx6Oy+82VRna0vGUE8SjP6IUFHk1x61yBrqclEV7zsfsykEjspSwF982YTzJuqa4HPhzPJomOrE3qQfB8R8FzBWlBZqfG5353V2+HGazlykSrPxKGnNuUf+mI0nMQeXmw20KxvrhDvg0t8JTDLw8PpC7HebNMer23S0O4iG31i9ivPyNNA5aNBr2jU17yjVtEVsj6Y3tEEWR0viMPA/KB3OBdGkBIxXZWclHfapidTx9Mrp4S3uIr1QoK4vJUcWCnW6Pb/wSRFDfhpoKkWs4+5qNQnwX/BpFgKaZSSOUkGnM8P9Ro85V79Uh4+p+ulkMQnHzS8mu6nc4446Lc9QNoZK3QJ3w657GyHkZ/Czp5lwN9pooY1Qv3QLn6OKnkAOOaWRE+WQXKqSZd7ZDRWK6Rn7UN91mpC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187d9674-d4e0-4e8f-211c-08daf9770ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 17:11:33.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6moR+62CTnZOQH1vSvpTGqEW4r1hQAnYj/CF8NnPacZXJmVv975ynlhHzTBoYePZG+8XlhulDVXqofxNRI59ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180144
X-Proofpoint-ORIG-GUID: ZurjhSB2ZSm5PYd9ZaWPELbewpfGEUXq
X-Proofpoint-GUID: ZurjhSB2ZSm5PYd9ZaWPELbewpfGEUXq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 12:06 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-01-18 at 16:39 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 18, 2023, at 11:29 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>=20
>>> On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote=
:
>>>>=20
>>>> On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
>>>>> On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrot=
e:
>>>>>>=20
>>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>>> embedded in the compound and is used directly in synchronous copies.=
 The
>>>>>> other is dynamically allocated, refcounted and tracked in the client
>>>>>> struture. For the embedded one, the cleanup just involves releasing =
any
>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is a b=
it
>>>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>>>>=20
>>>>>> There is at least one potential refcount leak in this code now. If t=
he
>>>>>> kthread_create call fails, then both the src and dst nfsd_files in t=
he
>>>>>> original nfsd4_copy object are leaked.
>>>>>=20
>>>>> I don't believe that's true. If kthread_create thread fails we call
>>>>> cleanup_async_copy() that does a put on the file descriptors.
>>>>>=20
>>>>=20
>>>> You mean this?
>>>>=20
>>>> out_err:
>>>>       if (async_copy)
>>>>               cleanup_async_copy(async_copy);
>>>>=20
>>>> That puts the references that were taken in dup_copy_fields, but the
>>>> original (embedded) nfsd4_copy also holds references and those are not
>>>> being put in this codepath.
>>>=20
>>> Can you please point out where do we take a reference on the original c=
opy?
>>>=20
>>>>>> The cleanup in this codepath is also sort of weird. In the async cop=
y
>>>>>> case, we'll have up to four nfsd_file references (src and dst for bo=
th
>>>>>> flavors of copy structure).
>>>>>=20
>>>>> That's not true. There is a careful distinction between intra -- whic=
h
>>>>> had 2 valid file pointers and does a get on both as they both point t=
o
>>>>> something that's opened on this server--- but inter -- only does a ge=
t
>>>>> on the dst file descriptor, the src doesn't exit. And yes I realize
>>>>> the code checks for nfs_src being null which it should be but it make=
s
>>>>> the code less clear and at some point somebody might want to decide t=
o
>>>>> really do a put on it.
>>>>>=20
>>>>=20
>>>> This is part of the problem here. We have a nfsd4_copy structure, and
>>>> depending on what has been done to it, you need to call different
>>>> methods to clean it up. That seems like a real antipattern to me.
>>>=20
>>> But they call different methods because different things need to be
>>> done there and it makes it clear what needs to be for what type of
>>> copy.
>>=20
>> In cases like this, it makes sense to consider using types to
>> ensure the code can't do the wrong thing. So you might want to
>> have a struct nfs4_copy_A for the inter code to use, and a struct
>> nfs4_copy_B for the intra code to use. Sharing the same struct
>> for both use cases is probably what's confusing to human readers.
>>=20
>> I've never been a stickler for removing every last ounce of code
>> duplication. Here, it might help to have a little duplication
>> just to make it easier to reason about the reference counting in
>> the two use cases.
>>=20
>> That's my view from the mountain top, worth every penny you paid
>> for it.
>>=20
>=20
> +1
>=20
> The nfsd4_copy structure has a lot of fields in it that only matter for
> the async copy case. ISTM that nfsd4_copy (the function) should
> dynamically allocate a struct nfsd4_async_copy that contains a
> nfsd4_copy and whatever other fields are needed.
>=20
> Then, we could trim down struct nfsd4_copy to just the info needed.

Yeah, some of those fields are actually quite large, like filehandles.


> For instance, the nf_src and nf_dst fields really don't need to be in
> nfsd4_copy. For the synchronous copy case, we can just keep those
> pointers on the stack, and for the async case they would be inside the
> larger structure.
>=20
> That would allow us to trim down the footprint of the compound union
> too.

That seems sensible. Do you feel like redriving this clean-up series
with the changes you describe above?


--
Chuck Lever



