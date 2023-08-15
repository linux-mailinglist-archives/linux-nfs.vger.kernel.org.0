Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DE477D3A1
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjHOTvb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Aug 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbjHOTvM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Aug 2023 15:51:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6472110
        for <linux-nfs@vger.kernel.org>; Tue, 15 Aug 2023 12:51:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FJjaQ1000954;
        Tue, 15 Aug 2023 19:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mwcWXrozt2UmdnqjDmRaT/oMthxOsLpfBmKiCnV/UZE=;
 b=U0+/ahPSDfq++1CqywLCJiDX4Ao2DeJ6blvM648O/AtldTEQhwLYmIAC1nQr/e88jOqc
 dPC7ayz/FBkaM/C9v3pULablsGJVu02qfzguC7Y23fngBb0IQ+kYYUipBIYxVD/nBELv
 1Iam8Kjq5eIlNojv3xCWH5Uz9DZXXfScY7Q/aTZw+jFoRFkhfN7s8A/Qvdcv6IEqy4l1
 Mqw//ZxZaR8+/rMrsaxPX8fq1Z9UuZEujYRkUp9jS3/5j9/XzDtBM6VBN8z+ruGLcaRq
 mauwQuaNuvv2o82p88ZnRv7KFBNIQx/3kBjP3Exb5pM5/6w6ZMH2QX3otAIt3NTparaM 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwnjbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 19:50:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FIB8Ee040096;
        Tue, 15 Aug 2023 19:50:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0r8fh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 19:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNPssfkhm/EYVh/9Tfp6qAV1+njMM0gAcsFncthQTmyggFAz3V8MLw6qgJAGMj71+I5cPYN1dhnCHojImsAs4G0q3C2zSl6AQ0NrEoDh2u2UKeuNbAEewZsSPd4BU+CkrBkJWUqZXninH7Nat914HDm+NwjM4BgQSFvF8QxPSSs9jhbmiI78VzSiG9f/+JOIqi/7HsSRRmS4WCxM38CvC7FUfSHRfoRsDvVQPxaelHXEyBWwuEs6pdikHog6ZVYz1be8QVu5A02sQZ0R257d5qlgdTIoASvAR5JXSuKCNqAu8c4TyMZKRvXM3c0T+6pG7LUz9AqJ0xrynJ/N9IU/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwcWXrozt2UmdnqjDmRaT/oMthxOsLpfBmKiCnV/UZE=;
 b=InvIS1++lwVvepCrTXohlHWQe19iZwl+Ob1dYnYDtB/Crf6Ucmv2rsCLZdSQmtnwUrry4TpeaTzowdY/kUEmeKTSO0Zpq/D5NHyp6jJCCAddOCQ10cfoqbH6j9mDISsyJOrr967743bHKiIxQnShK41BOKjF7IJEeqlgrmPIYujUVfFrlscdsQSPSif6V/Y/ZyEfYeRi53MvLCucUvRrweLx5ck7aS9RYswgEYDlCvjIeu4uoonio1mMpGvHqkCRZLkNHQtzaNvmemntqgW8v01J1xN06ZKTm5kpjj+5xYWcuYIsnCJE6cOb/6cFkvkd35p6KT8YWJOSiK3biXzFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwcWXrozt2UmdnqjDmRaT/oMthxOsLpfBmKiCnV/UZE=;
 b=Pgiiy6cfSIU2aQjU5HSCfQREBErFiimVbPMjt7EC8NN7LBQDQhOshxudYpei3bFFG/vjy89wj4B77DF85eXjWsmuaj+ZGeS+7j79yqWM8ICU5B4h4gJsVjEG+VCujmAMhP3ujx+buqbB/LM5uP6rlUkSDRniCMJDt56Jw3or5RY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5253.namprd10.prod.outlook.com (2603:10b6:408:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:50:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 19:50:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: possible GETDEVICEINFO encoder bug
Thread-Topic: possible GETDEVICEINFO encoder bug
Thread-Index: AQHZz7HMv+dn0G+VukCAVbsB8nez6w==
Date:   Tue, 15 Aug 2023 19:50:53 +0000
Message-ID: <E6E5C359-522D-41CD-BDD3-AD99763BABBE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5253:EE_
x-ms-office365-filtering-correlation-id: e0ac22a0-a78d-4e7a-a0f3-08db9dc8ef08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeukoJ6IEDbfBiXwrQgw1AyohiQDUsK+w/Ww3GJ+TIVSbmFywEKT81KDKvl0rK/4avP7ArJAJPNT6wcJ3plq5t7Bc6VsXhkE3LqLt/pc4cJIyafPEzvdMH0iwVrmIPcWMbV2UomdmDUP4RoM8Uua0IcImhDXFAY27xJ3nkBZqL+bdNnIcfjOhLJiWddgnb1KAN/OLFOyRSqsbDGUS+tJtbQTOkOd8EH18YURCwO9xj4w5/r7IAMy73ODkNImwOQBNw7nbo0J1J1lzOXDzS26WkfUZlytQUMd4qSJcJE1sDZMxB6duW1W6WZCdsKRngmG9nRbWy8hzYJQLhA/MGE69vljbr9eiztMEdjGm4793qMQy9qJf2Y5zY5LIwfPcK6H8E8Etx3suQFXyDKCvZzjSOeXnHVc2D7wjraba7Sh+4LED66t+Ma5MDerIxBEi0Xt3gEeUGS/iaxgwSPD9rdh0DAoT8PQWtUAkMvogaDO/vIkgI9BigmdVKFJj6HIaikUqY4j/45Fw4qB+eEylLyGsm2+m4aievpfPKSTFAX6L4IRMY/DPAwSj2oGmvTwpGqF4HlHT+o2OFWrBrs7oIc05h15MsAcjhYpOc6uAHoKqGAPRSr8PmNiqBgpXa8nAdjSHpyIe0TjBTdqlKDcKOQKLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(1800799009)(186009)(451199024)(91956017)(66556008)(8936002)(38070700005)(66476007)(38100700002)(2906002)(86362001)(71200400001)(66946007)(33656002)(2616005)(6512007)(6486002)(26005)(478600001)(4326008)(6916009)(316002)(6506007)(8676002)(64756008)(66446008)(41300700001)(5660300002)(76116006)(122000001)(83380400001)(36756003)(3480700007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rt/POAM6lOrEso/tbz6UQGWvCw2kkugu9COpLXEUBUNux1/Xp0zuLZDEWEVG?=
 =?us-ascii?Q?qXTU50BS+nAYVyjcn3gt3IPa61/bF2V60noHd27PjIviGwMJh4PmFu5fStig?=
 =?us-ascii?Q?bu8U64UxNV/loQlyVVIxL0TBwU7KZAGpEKmIcP4GVos0xTpXYyAM7Rfs8BFQ?=
 =?us-ascii?Q?SLnmiZJUusCm/871UsBArSeA+EOSR43KcR5a4ZDU/bR2azUTIQCoC9SwH1ax?=
 =?us-ascii?Q?A26Gx3BY+8MybXJ+USYohTOak52KjOL0SgUpzim96YNOKsJo/G2IevYyazWs?=
 =?us-ascii?Q?5ZyZCGkuXxRp1vIoGbt+BcThRQxNJ1uKhaU6+6svmpUs9j2U5nWd7WfAgVlS?=
 =?us-ascii?Q?o3HJmtayEs/4rQR1bFQF58cN2uT4P/1Xig0CAge+s29j07soCxMQCgxFuGEq?=
 =?us-ascii?Q?wH7jAUXvnvV5pGoDnhHoZrSJECTP5g9T0F2TudJRH44o4/02DGA7QdLiCb+D?=
 =?us-ascii?Q?lrTIOmGuib6ncRAbEPOSd3gXsYrIqkGZ6ZReDpvAMpbECWo4S98VZChW3v5e?=
 =?us-ascii?Q?b/K2iTDNwpyGuVWJFarudT9rjkeaMpE7nteJkS4l5jPlZRDHqejCBP0uBVLl?=
 =?us-ascii?Q?gce1IP43lH+3+WXQMuuPzeV958BvgKYkI6j9MKCLqzBVXy1kc/5iYlY5HnvK?=
 =?us-ascii?Q?ko4r58qjkmP6tvOcpEjgap78G9YsT0YY7axK1aMiAADwBZkJnQvTxaYEUOSH?=
 =?us-ascii?Q?VvDQoirgJK8nQgAD9SvV4/LUc1fGccThpGuSadBhdiQmgfC+du14eW+FNY7s?=
 =?us-ascii?Q?B9EjURMcjiinVzlRVgxPTdVH+Pw5TCgsHU9wdzuIy0YtunkemX9Fuu41Tiin?=
 =?us-ascii?Q?3Wy/8Qkv4x9LFd6+yjj2gMOP2t42ypuga+8N9be4gHPidRP1k9F27LZmyFLD?=
 =?us-ascii?Q?7pGga6RyyuDSOV86+EhBl7PMH66Kf+54CdTIhdKRw0RHBSmBAf3VFEHe3Tim?=
 =?us-ascii?Q?NYwuz2bBA6kNKoGXPIl5pzwogKvWJy/iSNOhRRRDweuDbGXWoi8/9D/YWi84?=
 =?us-ascii?Q?QOWaYmzaPcoDKD5eurnKO+y7HCsF98McXJemchygEKQPhMrqpF/KsOxjDcmG?=
 =?us-ascii?Q?St40KqgLXLEraie3STVICTrjaYEJy6eoQV/5HT4ANLBGj+doSyVKWNu51GEi?=
 =?us-ascii?Q?2iVOEhrAGX4kHFCPcobHV6bhJ4+/6CCN/YirLGlYO1uLElCzMpG3wb8PxN0T?=
 =?us-ascii?Q?4T3rWzS7vXQ0WSwc6FtcwIo/ug92EONpyjO12VXJsY4XY90JEEwbkGWwt0hv?=
 =?us-ascii?Q?nEM7iAPguotn+1r/brSaD/LITqvIlWu7mDG3l5hU7a/hpGqlGEEPN1DPPIdK?=
 =?us-ascii?Q?PqrwQC2Osm9y+KrLWRrRM8pPJT5EhDRoeyWQ1IZvddfPgGYK2+QPVv3P1vcU?=
 =?us-ascii?Q?AFKmX6PkNzu0DkZPEWB4UM3iGP1UGJh/pX9HRdtdF6yuLVkCEJ0ThEA3I4Jk?=
 =?us-ascii?Q?s9flZXzV1Vi5MLattTNy3p2bZovskvdzbgpdmc0SSPjekQX7tTL3ENB7T6iE?=
 =?us-ascii?Q?M/FBvYZThAVNULFGqm3xvdcRXQKJj/QGw7W5ZpM4BKXqsDNn0GdSHi+RpKZC?=
 =?us-ascii?Q?z8UaXhNG9fe4LaC73EyNoyEbcxldl31BI9EflYIJAZTqkWTyMCek4saFdOjG?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D13E645F4E7734EB958C014CB458A0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t81BFO5b3bBHnTyILLwdugPcT5aIP/jqLGaWxnRPngYeGv8dzvZ2xe8UfVNfmOSgLOuCwdt113KkMLCP/qhZv4Bd6x+YMC49uXQcS5ZbFgVWFlEE+xkjsP4K/nhyXNYArzFYK3woCjP2bxFEEDJ9w6qlA5mLqnI3nzbT/Uwc5rDJXqmt+htXen/+KnOnWIYtXkvM1n6g2jAnEOGGCEkQtrhb1pwdthMN2NkMZzNKEDk+5N3zyV+lkEcHcolClFqAp74qHqBZnv4jtQFYL5ZKa58QJ7IO/f+Zs6CkXdJ0v5yKwHIHSiCIN5KhQIzeLk/LweX58uH14YAtMfaXEjvcsuUKqd+jKKikpXmMRcDLSlRaLTWEVJLrrweEP02dXShCObrkahO1PwoXvObP7SldnUcZohKXGPURoIB2/bqUEAQt7rk47c0pAmi9/SXS88fciQmBFmXbv9KPY19xLerrN4uTKqRliAqVP5QfYbevOcNqhEITch5ifYZDoDFH0z/R3v1Hl0F/VNkgYCxtgy3rv6AyLKqRoxXS7R0myX7QfNOONDuAWxq4hnwL95fEfvNrEQjeAEutmMXdNBnscoFoDYEQAkee90Wn8HKZWTQGHhgv+GeaakDS7YX3gYFWJk348zSC8ohPzAzCOjzLyn77Vyf23sLeg+3pQSHBDus7nPm+wOAQ1pIGa7GNk6F1EMvubzaejfFxsXAJUxttFLsP+0rfqDyYpAio41KASFKpmD6BTc1kWqbPuJxIkQ6eoOlVrfUBMtyjznNIgxqGLNJBNA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ac22a0-a78d-4e7a-a0f3-08db9dc8ef08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 19:50:53.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbZmDIp/s0kFWeTOTjgrbZGnfdH98S5UUiI9zEXkg/PQwmSZyx/Hrb+PARUIPEmODv9EhoOS1sfn1FqyeNlw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=886 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150179
X-Proofpoint-ORIG-GUID: sxy37TsUFkOjZtFlP7pCh6H0Saf5vo42
X-Proofpoint-GUID: sxy37TsUFkOjZtFlP7pCh6H0Saf5vo42
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I've been auditing the server-side NFSv4 XDR encoders, and encountered
something that looks like a bug. This is nfsd4_encode_getdeviceinfo():


4675         p =3D xdr_reserve_space(xdr, 4);
4676         if (!p)
4677                 return nfserr_resource;
4678=20
4679         *p++ =3D cpu_to_be32(gdev->gd_layout_type);
4680=20
4681         /* If maxcount is 0 then just update notifications */
4682         if (gdev->gd_maxcount !=3D 0) {
4683                 ops =3D nfsd4_layout_ops[gdev->gd_layout_type];
4684                 nfserr =3D ops->encode_getdeviceinfo(xdr, gdev);
4685                 if (nfserr) {               4686                      =
   /*
4687                          * We don't bother to burden the layout driver=
s with
4688                          * enforcing gd_maxcount, just tell the client=
 to
4689                          * come back with a bigger buffer if it's not =
enough.
4690                          */
4691                         if (xdr->buf->len + 4 > gdev->gd_maxcount)
4692                                 goto toosmall;
4693                         return nfserr;
4694                 }
4695         }
4696          4697         if (gdev->gd_notify_types) {
4698                 p =3D xdr_reserve_space(xdr, 4 + 4);
4699                 if (!p)
4700                         return nfserr_resource;
4701                 *p++ =3D cpu_to_be32(1);                  /* bitmap le=
ngth */
4702                 *p++ =3D cpu_to_be32(gdev->gd_notify_types);
4703         } else {
4704                 p =3D xdr_reserve_space(xdr, 4);
4705                 if (!p)
4706                         return nfserr_resource;
4707                 *p++ =3D 0;
4708         }
4709=20

The XDR specification looks like this:

struct device_addr4 {
        layouttype4 da_layout_type;
        opaque da_addr_body<>;
};

struct GETDEVICEINFO4resok {
        device_addr4 gdir_device_addr;
        bitmap4 gdir_notification;
};

union GETDEVICEINFO4res switch (nfsstat4 gdir_status) {
case NFS4_OK:
        GETDEVICEINFO4resok gdir_resok4;
case NFS4ERR_TOOSMALL:
        count4 gdir_mincount;
default:
        void;
};

What concerns me is "If maxcount is 0 then just update
notifications".

When the client provides a zero gd_maxcount, then we
encode the da_layout_type field, and then appear to
skip the da_addr_body field and proceed to
encode gdir_notification field.

Seems like there's no option in the specification not to
encode da_addr_body. If gd_maxcount is zero, shouldn't we
encode a zero-length opaque for da_addr_body before encoding
gdir_notification?

I see that it's been this way since this encoder was introduced.


--
Chuck Lever


