Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6F654368
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLVOz0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 09:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLVOzZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 09:55:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514EE1D329
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 06:55:24 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMDOIiq006914;
        Thu, 22 Dec 2022 14:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k2PGzuOi40nXml67eGxM1yzMxNh7wCpJ4m1OT/yU21I=;
 b=p1FkirJcKjKp7Bu8UQM6ZopIR3cOfdx3MwbaQizAHD2BGc1F/Jv21heSkQUZOm1gcT9O
 2PIvpE22ApRsrcuQThXo82edv58W6mtuzJXiV0Wg3+HsEONV/VHYOdyZIAnuQ6SsSmos
 +joHsJSzs+J9T6WbyAtwi/fU76yLVIIO3lf2rcmqef4taEl9Bbz9zS2S+CAuZUJje6BI
 8EJCGx9lx6byAVevjsqXLXWwWFc4MnL6RCOYpENal+I2dLxrlrSUxZ+pKaAPm77f1vF2
 Wj3XUWrUlz/69kGaf5E+JZJVX1rBrJWY7Yxet3UKdOwdCsEZ9rRan65SjQq4rhdCrQ5N lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tnkx55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:55:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMDXdDp030285;
        Thu, 22 Dec 2022 14:55:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh478a4xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtKLQuTqEcHDYMACjX3DAdLLC5drnXe9Hcf0wVOjU53UJ4uix0H7XojI3IQMePKIi0EJa2v20hqdxz56I11yLT6yINcI2SKuIMLhdWp9QT2yFMG0aptBKz2tTBp6g77zg0f4g2OaAW0VJfaZ5xhRr7Cggs95pyZbLcuqeJRnWnI0tRHtojkOqbQSfUzylvZAdrtxWrqIdbAkNHy+rqGQjvFfwBWP1W7XFPKE6nc5LBWTtz/dKkQrnFm50Bg30z23w/Ywj7ADiVt56qHjuZ5vhpQTiq69CmwMKzjxgGlppCncn5zwt7SAk2C90AX03syO5m+1kq2ORnaEvIMNfS9lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2PGzuOi40nXml67eGxM1yzMxNh7wCpJ4m1OT/yU21I=;
 b=Gif3daf65LKkKI3hDecCvKnBzIEK69j+eSfHTDvZjgu0jrNU0qGRSVpXDFyP1dZCR9hTkLDjBd8n2Bxxn9lmDxwqTuTRoSaNajW8l5ir1Lxq38HfGH1C80pBYMtoRc2dK3O2Tl2xg9k2GkleWIZuFWrz3a/MRcUeNiQT35lOco/HTMwXvpypDt/VcI4K0xDeiK9RH69qhvjF8SJ+mUr5ypLWuL5IKEc2Q0f4VhqurNtqm34f+DEFQkpos+mvbhETbsPoNGvi3YIlRmyYPevsMaPXrWW/a9eM1G80HdDh+aA1M3c9hEtyMl1g2fbejOvWwDSoJJz6+8UjfXXYQjRG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2PGzuOi40nXml67eGxM1yzMxNh7wCpJ4m1OT/yU21I=;
 b=YjFvQbpVDW9Zy5aYO+dZIt2mBoLPhT6Kko10Sjh62XkqRZ3LmBGVoxOsr06BdhmwKb4+h73ntuSSiCh+s1Y/O66eUJ5Bmc12UoHN2lNHzsD5XgpCtcSWyE2ms7u3oO2NRNx7kAkMAc5eL35POX7zTKr+IGFsQBkO15GjzXNf+NU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6471.namprd10.prod.outlook.com (2603:10b6:806:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Thu, 22 Dec
 2022 14:55:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 14:55:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] nfsd: shut down the NFSv4 state objects before the
 filecache
Thread-Topic: [PATCH] nfsd: shut down the NFSv4 state objects before the
 filecache
Thread-Index: AQHZFhTlqfDHokRUHkmZ89RJc2hqb655/puA
Date:   Thu, 22 Dec 2022 14:55:10 +0000
Message-ID: <3858C5C1-342C-4599-A1B5-BF55953D0CBB@oracle.com>
References: <20221222145130.162341-1-jlayton@kernel.org>
In-Reply-To: <20221222145130.162341-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6471:EE_
x-ms-office365-filtering-correlation-id: 91d5afa2-d5ed-4cb8-519f-08dae42c85fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqJxNkoF8aBITA4qXlw7JOclOk+rcnKF1dDbpOs3R+xWrdp1yc1QAUdut4m/3kYDewuHzyDRzpnGQtJqnaFg5uMxWB+WTl4XlsULveL+IrRIm2nVcbwaThRbfgRUrhHL9ne/c6R3YUkhyW8oBntzS1PPYDCz1ViDsnbVm4vlETAxq0muqWI2pMcu3KjKYwO+c1rmIbx9C2KT8SUku879fl8rUg+ht1lTC+SDIT/GqaS8d6qFscQ7VbTRqNneYvsRDC1fo9aLKPxaQLNZOMWrd144c3Rcf4EWYMX0RJQQhpqWPXtdSc//GI4AvQ1WgIiA/rlZ/FNLHdTu9veyN4UiNgSS81dS18vBCARjKIRGFvTp2cNGGAz+42yLNshi2fMLkLJo0dRbViqFqYHlGYhhA0zp+kRInZ6cD8MTOxZR8fg4yu7xwogJ5v1y5qT5f3b2phWQD3fTP8wvIiaOIHa/FcTyYyZiKsq2+aHqgxmEYO00iIwJO8o8g33zfrULVCvdekHVEQTL6L+3WkrA+wcUmGJsu+vL5obbeRO5zBxKuTGViAFHVGh1X4CRgiYNgJD9nCkj4P6UhzcDkTur7x5UvcTPKDpxU+pFDxgA8ZlyEDXgbTumk/NHRZzLkOb1t/CPcK5+Q/wVtZ7UW1EIWMfc3LI6F3KcFJ3ZLqkNIJ3GhVli5KxAj6QSKhu9ibok2ayupwUCAYVoHlClUphkiB89uNMX/bsCkd+1gGEVMb28dXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(36756003)(71200400001)(6486002)(2616005)(478600001)(8936002)(5660300002)(38100700002)(122000001)(38070700005)(2906002)(83380400001)(91956017)(54906003)(33656002)(6916009)(316002)(41300700001)(86362001)(66946007)(76116006)(66476007)(66446008)(64756008)(4326008)(8676002)(66556008)(53546011)(6506007)(26005)(186003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?67Gpjp9GMvRJD7462sSanITt+XJGGOBTuXEWM7nlIJEeI0mJp6Th+WS/tY+y?=
 =?us-ascii?Q?nac+8NYmWKBMsjEzeSryn54fJzUD0+ei7+wlKR4WKadC0FtN488sZqg8hWlv?=
 =?us-ascii?Q?f4Z8kGw8QqS/ryzgtwvWiH3STpfIId7wgEOj9lordgUUBhgBhKk+OBF0jAXV?=
 =?us-ascii?Q?Rv5BUx2lMh9q0ulLABgj9wZL18o8ovuvD9BYLgg6rqt3MgEMraL95j5/5PsO?=
 =?us-ascii?Q?Ntltz6iaca6vgTBQWacNkvoX/Y6ltL0E2Rk+56xolu8me8BjUV9h19+RO+Kn?=
 =?us-ascii?Q?emufubPQ+m8Ct+sT5k7b7hAqCBYJupLapfCjYS8RzFHRC+CIOeXEhYUg3xyD?=
 =?us-ascii?Q?eHvuWqhWAV/ndK19SHctZK6pRd0VIYs+JqfYZJF/zUuont4/6pNGdWMVwZYf?=
 =?us-ascii?Q?RHWDPw3/DJUkQj8aiPfHbEkCjpDnzMzBV1O15zTJyxN/S2f47LxxC6U6rC00?=
 =?us-ascii?Q?tmOjAzwSNmEw/W5CyG4fT6WmINHSbuZRa7ixL52qjLpy9f9n6RxaSlIRmwcm?=
 =?us-ascii?Q?1oidNDG/HP6RseJI0sBrsDUOvU+B+mqiaJi38X7M6Ej8K5r+1S7o42BpXhGr?=
 =?us-ascii?Q?HTMdZ1mPEtLNffjl7x+DMnMgS2JyqWE88p54LetiR5AxP2cSEMROPMHC6g9e?=
 =?us-ascii?Q?IzfnMvThaWA4IRKI4vh2JOg9atqyLqE8gIY/5KZ7+lgvLqyAQ0RYMgAftsR5?=
 =?us-ascii?Q?VFgId/EWOIsqwvamgH/DeO30xSOKjntHC63jY447I68yUSV2jjOi1k8/f7Tn?=
 =?us-ascii?Q?cwCvqW4D81hFjVVhtCkw1+yJ87Gz/s2NHxi1Gwqp3l3zvgeKwe6sC0DB75Qj?=
 =?us-ascii?Q?+3wZBIh+udqdcq3YWU4HxkQhAM6fzThH9MlCChnTPbPRepFiJw9J4c5NDhK4?=
 =?us-ascii?Q?U15o2bcqXpGIIVhcjkchcfkucjYTeA9OMbZ/ekzYrw8IBYwcF9vItGDM8esm?=
 =?us-ascii?Q?LQT4GKhTGRAkkantHjr9K5Oa2+bhd2fO+D6ctzU/H3+FoHwcEBgVgI0+YcAS?=
 =?us-ascii?Q?Wk6k32VsMRQvR5/xaU7MgzkNSNz3AAkM4H/Jfh7AshvWEs/Ijmhs04lj4pP8?=
 =?us-ascii?Q?72U5rcQjsgBajnlt83NEelyVottjo4+ockXm0ag/mO6YBerx1Qld0Hw0QbSw?=
 =?us-ascii?Q?EOIy9JcuLv4hKTAwr8brWdaCom7vU8tX2t2GEWake9VbcjQTTH4t66gQS3An?=
 =?us-ascii?Q?sPg+58SRivkLsC0ciJ4ZoM2JE4Szl3nR4ISa5TnZiU1sLBeb4iDL7oDBXjy2?=
 =?us-ascii?Q?EWXHcJUjQqm87JaKXj2DxMyjhACR1jAB4jdyRQJSZL2lmS0j0WKlUlc7a0r0?=
 =?us-ascii?Q?ppvRClCGB9tlVXSewFOu2X3Apvv6ubh5hCc1dWRiDZQR5MANtqjVHLnfwdpZ?=
 =?us-ascii?Q?NkZP3k9AUSRorfhskuoj78WjbYGlVl8ooiUC2Xd88VCtM8Scg33DSbLZjN3+?=
 =?us-ascii?Q?vTL2BFAakSmEDyCu/UoOd5AgVjMVQbVktKoDNp48DbFBdkEDqyiguVdK/Oyx?=
 =?us-ascii?Q?C4H3G7hgrdcx3M80H96O9IeAxbzirx1Xpjo/217Xh+RtETD3eS9OkqxClGpr?=
 =?us-ascii?Q?ApQUckJkSTccWqRSyD7R50tUQtqP00LPhRxEHoeZ7knPwKq51Vvn5A6EYWPw?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DD894DF58968B4D835C56CFC16D1042@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d5afa2-d5ed-4cb8-519f-08dae42c85fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 14:55:10.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZZeYKQuESZ7xea6QQeavOPEh8vKjx0RZxWPDdcGFPQrREbhy+ZCPzcBmEaXWrAXXep8vXa4SzTJULxiRHW3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_08,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220130
X-Proofpoint-ORIG-GUID: SY3HAIJC5JGEwnbcYhqaRMWFg6QR0Kk3
X-Proofpoint-GUID: SY3HAIJC5JGEwnbcYhqaRMWFg6QR0Kk3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 22, 2022, at 9:51 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Currently, we shut down the filecache before trying to clean up the
> stateids that depend on it. This leads to the kernel trying to free an
> nfsd_file twice, and a refcount overput on the nf_mark.
>=20
> Change the shutdown procedure to tear down all of the stateids prior
> to shutting down the filecache.
>=20
> Reported-and-Tested-by: Wang Yugui <wangyugui@e16-tech.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfssvc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 56fba1cba3af..325d3d3f1211 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -453,8 +453,8 @@ static void nfsd_shutdown_net(struct net *net)
> {
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
> -	nfsd_file_cache_shutdown_net(net);
> 	nfs4_state_shutdown_net(net);
> +	nfsd_file_cache_shutdown_net(net);
> 	if (nn->lockd_up) {
> 		lockd_down(net);
> 		nn->lockd_up =3D false;
> --=20
> 2.38.1
>=20

Hi Jeff, seems sensible. May I add:

Fixes: 5e113224c17e ("nfsd: nfsd_file cache entries should be per net names=
pace")

--
Chuck Lever



