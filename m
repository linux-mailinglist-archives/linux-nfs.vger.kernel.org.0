Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476B174E2DB
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 02:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGKA6g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 20:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKA6f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 20:58:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21732C0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 17:58:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJ9U7E023594;
        Tue, 11 Jul 2023 00:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7443bVtx0/rMh8hN0Jim1JSsw2oBUTAkpl5MzstU9us=;
 b=ajfNnVXsN1zNfMMpd/qj6ODY+P0w6AZwD9shwU7GCAvdYhuC7I3DldYUEGRLqLcjJS/K
 Kpv+LOa6aokyaBN04J7sVNIHni3h7lIkImpLG8q/ih1Dsjb2ZnYiXfuVwkefTzzYJbuG
 O3qYzwv8n/HZtYomEuXrebhK1em7M5MCp7sJJ5ozTZlUfqDzDbXH0UJY0IP8CRQm/QoF
 DjLBvD1CM3xdKyD5TPw35d5YclqyLSYtcD80sbapZJie65eUl8I3/sRkUPR9B3aaV/y8
 VHNsXdrLCEYd9T6pnoLpIZpXgxOeLhCR3Z8Vxnb8Y6WDo/GFOUeXdoonEeQ1ChPWBR6g 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud3uup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 00:58:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ANvNaI022918;
        Tue, 11 Jul 2023 00:58:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx846g2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 00:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuZZgbBskgoi3Cb6MTkwlYKabSQtkWb/WyvrjfsMldMY0nLPd7G+e1QIA21V0mnRbt3L9S+H2uB6r886AGhpGryh8xEBxuS+wNAxVWEXZ2qRRQeJBDrr8HF+Hl9uNMr92wHfk0QSiTB+cO/pT4EqYdU8oVQY2/vB2t0nR5tuGmqK9ofkdMwIB9U1c8W/gupmrtsKeQJxHupfgoz+TYoMDiIv4b+mcOoZhAlJY87FoNYXkUBSM29BpDRHLUYZxLKeTuW8CE3ZryUakkGL2ABA6WyN00MCAk3dFXg2EeBRLqPQiXQ81lMd3ybt7e+IUNwItgJkAAu0q6gf6P49g1kVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7443bVtx0/rMh8hN0Jim1JSsw2oBUTAkpl5MzstU9us=;
 b=XvZtdb3AlJkdai1Rll/SRG8VrZhHiLtxjlS/wTh0jUch/tIzQ9L3SAtmPHQR8IWwvEOZNzOUsgqsvyA8W6GF39bNpBvt46wJ0T/3lv9hTdrx20vXfpMrm+cH98bWBZdqwxZ24XKoFONG4osc8JF2xXdOkT4CSrKkkMOqNE+Cx/r3O+/Rs84nYiTqIFpk7GwihY25kriZkGxThXphhNlg71qFPMDzqpNkg2tY3jYV6PrF6fISl9yUNIz3JScnGxwdpXD+jg2RWPIls/z2mwxaPOXqVOfAlcr8VXuoeDOQiWodfBTP+2P9Y4KJTrlG8BeFIFjZwOcmln6c9AU5vH6QOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7443bVtx0/rMh8hN0Jim1JSsw2oBUTAkpl5MzstU9us=;
 b=iM/UoNU9iN5AAcFGc2f6YchPF4g+23LskNNeQgFC6dTQOhrbgAqYSSFGaYsDMhIhR61rOpIRsH13ffIWDCHpDk3wXTO+UJFdHuJyoxeN0IgtmIWCdKj/+RsAOOlAbvW1FoaNIRFylvTiz2TUQT05JkbKE6wcannOMccpipV6Pvs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 00:58:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 00:58:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Neil Brown <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
Thread-Topic: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
Thread-Index: AQHZs02RX5BKEn950kOti0uzTOYZhq+zUOoAgABuAAA=
Date:   Tue, 11 Jul 2023 00:58:21 +0000
Message-ID: <0D6735B0-77A8-4710-8EE7-1F8E382A139B@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900736644.7514.16807799597793601214.stgit@manet.1015granger.net>
 <9de14c8ef8584545ceef2179f0b57f84ef7706fe.camel@kernel.org>
In-Reply-To: <9de14c8ef8584545ceef2179f0b57f84ef7706fe.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4447:EE_
x-ms-office365-filtering-correlation-id: 2deab08e-0e84-4bde-c1cd-08db81a9ec0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUtxPOGymhLFOVNEFeMbpWbCxJduGAtZSaJWKj7OmdCDzB8gmowCsbgp3Si5hf4KMltqzpCxQpT4BQ1DrCy3kljJeby/CzPrP50Z2vRXgB3070P/fKF3puO9Lh5mNYLEEExKoML4ZTuAwk3gJ06imBbX0pLMaBIBtphnCW//kP5akKSjdFC/2hewEEOyYPCgkO8Z+g/f8tWULNxrL7ImIWWllK+fyEBwKXG+lPkX1po11B7VZvzhQ7xYcaoQgcQYbVDxUWJ3qQvlHzNBXIpxncvNnBRE9j7V1fvKy1OJV+fS0RIN3iWY5st0vA4QVYRy0Sy5GNSDggUvgTfekQVQ7olkN3bmS6wW6hwNcBEqxkeKmjjc1AeS4byy1Qdos8R+XVYRkKke/VBDd/aTglRLGkFIGFmIlQtG4wbkeWrqRROB6iDpBJ2joXOPlBxbCm1FV+KjWiEfZ2gazSsCc8A5DKqL7fzyFJv75qp1Exty+vJV1g/B9vEb7tfs/dbpRBHJt18S0KMCThd8wXelWIChPhrnLUj6j1PGMbO2G52LYhHnlPrItMQ+ycgTzGZXJt5dKoTMb/1xgiXVlJMH4jdqv7NafsTbUBZwRW/9t2OApJUkD8F/Af+IScN7JSKOygS9uKiPvy2TPK2Up6do6OpYMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(38100700002)(38070700005)(86362001)(66899021)(36756003)(33656002)(91956017)(6486002)(76116006)(54906003)(71200400001)(122000001)(6506007)(53546011)(186003)(26005)(6512007)(2616005)(66556008)(5660300002)(316002)(66476007)(478600001)(66946007)(8936002)(8676002)(2906002)(83380400001)(30864003)(4326008)(64756008)(66446008)(6916009)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRveWGAvG4nVbcsnJPLej+1YD3FeEtSpkoa4ioMOe6ktRLXR/iGf4lLwcGT1?=
 =?us-ascii?Q?z3J5wqQi6kZk0CwoUCj42sjx25vZGhVPL2EW9mneJ8JKMIlcCcmlxwfWpY2E?=
 =?us-ascii?Q?Qp9F3ZZaDJ5hrFFK0t8EOm00emMC+JHEKoRrbxNTq1Dq8JaUzShqPTWppFDT?=
 =?us-ascii?Q?07a7r5oglZDUqDECK3ipIg8c/r/dSIiJrQQU6T9j0/Jmu4l+786AdiDZ8ssI?=
 =?us-ascii?Q?x9Dl6+XNo+a3uLdKWIOVV4v8vquy5JP6yYovPEl+BUftiE159N2JZKkdRHbI?=
 =?us-ascii?Q?hFLXJXcQOQ6uEc7Rc4Ma7cyO5fzUS/Nw2RwBsy6HD0iXkLxH8fYtTuD24RcL?=
 =?us-ascii?Q?Mu3PjGZU0FFawo6txoOsHzWzifC0S721mSkGWsq/uW8Ze4h5EkXPe7hTYkn5?=
 =?us-ascii?Q?s9bQzPBYfBh1LUVbQxSMMuPi+MvIZr37mcZ5Aa9wxKIq6X6/0Y05Yx+O19M1?=
 =?us-ascii?Q?c1qNijNtbcjD1TEHdWOmncwYjGPbq2j2mLJHFoo5bY2Hq7UL6K8coeUpKYa1?=
 =?us-ascii?Q?gTUXGAcVhqCIMsrmWhJJ9mDWo0yTlkWgKjwnt89SzBCaWVSTjZo1hZ/eAZa1?=
 =?us-ascii?Q?y9YyX73JOHdmays9Kia7OL8pOT6Mm3YjJ8dZJRPV7uS/q6D+8i1pO+ZT9nca?=
 =?us-ascii?Q?LLxvcwt9fG3gtHcL9jhumH8PdJu/Deaql5O9stnzKel8HZ1J/ZknkA8j3PQL?=
 =?us-ascii?Q?zXKMPEubY36MwpQT8DeLXh3Xv4kJoxpvlMaKgYr3WM8kB7IF8BwdBZ163wG6?=
 =?us-ascii?Q?RKizm4RK7wFJsLkZdzupGeA2FHvm9IlrPA8N3rkQ25zYLI8UW1k2tVWdCU7I?=
 =?us-ascii?Q?iH/FhPMHHOYzSOvTGhapY9UAmn7En0Lw0mGeQ91gmQ/bHdFa/BpfZwFuXysm?=
 =?us-ascii?Q?ErG6mlUz/3kphJt4UpGadaOf0stmuH855Q4hDkUOE0y5YnK7f9Ij7uF+PYlf?=
 =?us-ascii?Q?jAREKerjinANIulFHuM8uGunLFI88ogl2PleYeyXIrjAcSTmRI5AZeHFTJj+?=
 =?us-ascii?Q?NfCXOaNPrUS5dEqU2NdVzI6hvPMkQyIf7o1J2iiQVPp5hOLpfSDmzz188nkl?=
 =?us-ascii?Q?2HAfzEAD9oGgF7LQAZfkuSghrQ7Bq/jJ3fKfIHcoCwByNrIA1OxZ02J2k7aW?=
 =?us-ascii?Q?E8FxVImB5gHq6t1KQ61+7PToWX71eNsuB5Ea0BqWQDg+++jvKP3qLT3gyB07?=
 =?us-ascii?Q?asazWDui/d0uT1lJ/Ijq7OvA8spjxPYTaG0AxqCG5kKUnbDOEippDvjtI6UW?=
 =?us-ascii?Q?w6PtfvYWHSEmSwhum/F9Tppcxpc+JNPVBM2Yarnmdum1tgp98CNNkxpas610?=
 =?us-ascii?Q?+ZiseiHEMuo79HKJa1UrBs0nt84U5i3CxxbXSlqai7ZFPcLFEA5+rTBHqKIA?=
 =?us-ascii?Q?TGCxozov2wr73YtyCQGTKHnAWwNkUkij7SwWXecfN9AqxYYNZG0YtgCvJ/Jb?=
 =?us-ascii?Q?1NmeR0YnrH8QjHjBj6WydbcnaFcxp3mdCvxSBfdt+MVPXVS6MBkZXCDeDGRb?=
 =?us-ascii?Q?eMJrc4+JPsEgt8iwabnvfKfV/GA8qww9zB08qeccYTK8ZfCGlwXwj50hIzDq?=
 =?us-ascii?Q?lkcSaZJrscYNA1PyQc6zCUKsuFG8NyTQq+2GYpAKthwgMbHmIC+Gqel4wtz/?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <693DB4F04BBDD548B820DEFB4AD743AD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J0bvumPwNDq2kGGuQphDHlCPMko3cW3zA1K8eSj7+ui4oGHKlVAkGSLlKNDavlKfbikZAmbNVUufHHartk+VJ5ug27IKHpEhQouxpzIrGqpvaF6cO1ArTIwR1CCNWrOUB1S/HfMtAO252Kq79tKRPGUSLsn7HjrNJeCT/sRVpyD5E4XYr2m3dIBzJYnmem+lZWwVQ+mteWb3n5I5t46p9ieTQBWXA6j5edw4r2sb+A3HJwXj+uUDRqnlOV9WLsEDip4R7vpS/pcBq8VqpTK0MV8sChVsB8k2Yj1nIa6p/j4Lh6CgX+fWIGVJjUeReiC94ov4uus+m8+F88woYzWNRNEg4SXGdxXT5Omiw9rBeI2jIKGH0ZkBywc2skKUe9F4ykhNg2ch8EqaVYzevykuxmaiLN7f4lbWjV0PgMkWFfDvHl2O2mbh7BKTOvzQzIO1B2aXNZXusKQzKKE2PpPDlmd17mC1Xt3184EexhXGHl2HVUDGoNHjbdTx5/Z4x/J/TN/BNI7ZCIsQ5LGDc0kABPRYQcGLPRTppEoOKGbDkmDYs/9hVtSaAm8FokkcuQrnes8PEv7l9bI+BBfIyoV9UOU4dHf446rkr3q0SiWeegZ0eMtYixY74R11uH2YTB6ACPTjhayKdP22BUCyHQkepdg3KYVgs32VfPYDQxWd9rSL5/3ySz3OaQ88WA1KRrpyKat07OUekLkah+i2t3ppOeMtZGImifchB9w/k+dDhdy0+jwxs22WrHLo5+itUgOL5DnRqfXEsNXnE8d5WZXUYSodp9ZZZ3Wzt6YalY6uHvYJlLeiG7r5ee6VhI3egEFWHHm4RlDgFPhvn5Eijmnc1CGi0hOdKG5meFURLyIjaSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deab08e-0e84-4bde-c1cd-08db81a9ec0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 00:58:21.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSn1Szb/OpYlzBDfSn1c09NTUN1q2zVpM39zvLc/GlwGY8DPmWBEUY1lB0hVc1NUI4ZEZFW1TfDyp9GUn8mrDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_18,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110006
X-Proofpoint-ORIG-GUID: fP5WWnsRSLIVgaVGDOgL5dKhPDB9tTKe
X-Proofpoint-GUID: fP5WWnsRSLIVgaVGDOgL5dKhPDB9tTKe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-07-10 at 12:42 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> We want a thread lookup operation that can be done with RCU only,
>> but also we want to avoid the linked-list walk, which does not scale
>> well in the number of pool threads.
>>=20
>> This patch splits out the use of the sp_lock to protect the set
>> of threads. Svc thread information is now protected by the xarray's
>> lock (when making thread count changes) and the RCU read lock (when
>> only looking up a thread).
>>=20
>> Since thread count changes are done only via nfsd filesystem API,
>> which runs only in process context, we can safely dispense with the
>> use of a bottom-half-disabled lock.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfssvc.c              |    3 +-
>> include/linux/sunrpc/svc.h    |   11 +++----
>> include/trace/events/sunrpc.h |   47 ++++++++++++++++++++++++++++-
>> net/sunrpc/svc.c              |   67 +++++++++++++++++++++++++----------=
------
>> net/sunrpc/svc_xprt.c         |    2 +
>> 5 files changed, 94 insertions(+), 36 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index 2154fa63c5f2..d42b2a40c93c 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -62,8 +62,7 @@ static __be32 nfsd_init_request(struct svc_rqst *,
>>  * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point =
to a
>>  * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unles=
s
>>  * nn->keep_active is set).  That number of nfsd threads must
>> - * exist and each must be listed in ->sp_all_threads in some entry of
>> - * ->sv_pools[].
>> + * exist and each must be listed in some entry of ->sv_pools[].
>>  *
>>  * Each active thread holds a counted reference on nn->nfsd_serv, as doe=
s
>>  * the nn->keep_active flag and various transient calls to svc_get().
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 9dd3b16cc4c2..86377506a514 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -32,10 +32,10 @@
>>  */
>> struct svc_pool {
>> unsigned int sp_id;     /* pool id; also node id on NUMA */
>> - spinlock_t sp_lock; /* protects all fields */
>> + spinlock_t sp_lock; /* protects sp_sockets */
>> struct list_head sp_sockets; /* pending sockets */
>> unsigned int sp_nrthreads; /* # of threads in pool */
>> - struct list_head sp_all_threads; /* all server threads */
>> + struct xarray sp_thread_xa;
>>=20
>> /* statistics on pool operation */
>> struct percpu_counter sp_messages_arrived;
>> @@ -196,7 +196,6 @@ extern u32 svc_max_payload(const struct svc_rqst *rq=
stp);
>>  * processed.
>>  */
>> struct svc_rqst {
>> - struct list_head rq_all; /* all threads list */
>> struct rcu_head rq_rcu_head; /* for RCU deferred kfree */
>> struct svc_xprt * rq_xprt; /* transport ptr */
>>=20
>> @@ -241,10 +240,10 @@ struct svc_rqst {
>> #define RQ_SPLICE_OK (4) /* turned off in gss privacy
>> * to prevent encrypting page
>> * cache pages */
>> -#define RQ_VICTIM (5) /* about to be shut down */
>> -#define RQ_BUSY (6) /* request is busy */
>> -#define RQ_DATA (7) /* request has data */
>> +#define RQ_BUSY (5) /* request is busy */
>> +#define RQ_DATA (6) /* request has data */
>> unsigned long rq_flags; /* flags field */
>> + u32 rq_thread_id; /* xarray index */
>> ktime_t rq_qtime; /* enqueue time */
>>=20
>> void * rq_argp; /* decoded arguments */
>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc=
.h
>> index 60c8e03268d4..ea43c6059bdb 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>> svc_rqst_flag(USEDEFERRAL) \
>> svc_rqst_flag(DROPME) \
>> svc_rqst_flag(SPLICE_OK) \
>> - svc_rqst_flag(VICTIM) \
>> svc_rqst_flag(BUSY) \
>> svc_rqst_flag_end(DATA)
>>=20
>> @@ -2118,6 +2117,52 @@ TRACE_EVENT(svc_pool_starved,
>> )
>> );
>>=20
>> +DECLARE_EVENT_CLASS(svc_thread_lifetime_class,
>> + TP_PROTO(
>> + const struct svc_serv *serv,
>> + const struct svc_pool *pool,
>> + const struct svc_rqst *rqstp
>> + ),
>> +
>> + TP_ARGS(serv, pool, rqstp),
>> +
>> + TP_STRUCT__entry(
>> + __string(name, serv->sv_name)
>> + __field(int, pool_id)
>> + __field(unsigned int, nrthreads)
>> + __field(unsigned long, pool_flags)
>> + __field(u32, thread_id)
>> + __field(const void *, rqstp)
>> + ),
>> +
>> + TP_fast_assign(
>> + __assign_str(name, serv->sv_name);
>> + __entry->pool_id =3D pool->sp_id;
>> + __entry->nrthreads =3D pool->sp_nrthreads;
>> + __entry->pool_flags =3D pool->sp_flags;
>> + __entry->thread_id =3D rqstp->rq_thread_id;
>> + __entry->rqstp =3D rqstp;
>> + ),
>> +
>> + TP_printk("service=3D%s pool=3D%d pool_flags=3D%s nrthreads=3D%u threa=
d_id=3D%u",
>> + __get_str(name), __entry->pool_id,
>> + show_svc_pool_flags(__entry->pool_flags),
>> + __entry->nrthreads, __entry->thread_id
>> + )
>> +);
>> +
>> +#define DEFINE_SVC_THREAD_LIFETIME_EVENT(name) \
>> + DEFINE_EVENT(svc_thread_lifetime_class, svc_pool_##name, \
>> + TP_PROTO( \
>> + const struct svc_serv *serv, \
>> + const struct svc_pool *pool, \
>> + const struct svc_rqst *rqstp \
>> + ), \
>> + TP_ARGS(serv, pool, rqstp))
>> +
>> +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_init);
>> +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_exit);
>> +
>> DECLARE_EVENT_CLASS(svc_xprt_event,
>> TP_PROTO(
>> const struct svc_xprt *xprt
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index ad29df00b454..109d7f047385 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -507,8 +507,8 @@ __svc_create(struct svc_program *prog, unsigned int =
bufsize, int npools,
>>=20
>> pool->sp_id =3D i;
>> INIT_LIST_HEAD(&pool->sp_sockets);
>> - INIT_LIST_HEAD(&pool->sp_all_threads);
>> spin_lock_init(&pool->sp_lock);
>> + xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
>>=20
>> percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
>> percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
>> @@ -596,6 +596,8 @@ svc_destroy(struct kref *ref)
>> percpu_counter_destroy(&pool->sp_threads_timedout);
>> percpu_counter_destroy(&pool->sp_threads_starved);
>> percpu_counter_destroy(&pool->sp_threads_no_work);
>> +
>> + xa_destroy(&pool->sp_thread_xa);
>> }
>> kfree(serv->sv_pools);
>> kfree(serv);
>> @@ -676,7 +678,11 @@ EXPORT_SYMBOL_GPL(svc_rqst_alloc);
>> static struct svc_rqst *
>> svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int nod=
e)
>> {
>> + struct xa_limit limit =3D {
>> + .max =3D U32_MAX,
>> + };
>> struct svc_rqst *rqstp;
>> + int ret;
>>=20
>> rqstp =3D svc_rqst_alloc(serv, pool, node);
>> if (!rqstp)
>> @@ -687,11 +693,21 @@ svc_prepare_thread(struct svc_serv *serv, struct s=
vc_pool *pool, int node)
>> serv->sv_nrthreads +=3D 1;
>> spin_unlock_bh(&serv->sv_lock);
>>=20
>> - spin_lock_bh(&pool->sp_lock);
>> + xa_lock(&pool->sp_thread_xa);
>> + ret =3D __xa_alloc(&pool->sp_thread_xa, &rqstp->rq_thread_id, rqstp,
>> + limit, GFP_KERNEL);
>> + if (ret) {
>> + xa_unlock(&pool->sp_thread_xa);
>> + goto out_free;
>> + }
>> pool->sp_nrthreads++;
>> - list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
>> - spin_unlock_bh(&pool->sp_lock);
>> + xa_unlock(&pool->sp_thread_xa);
>> + trace_svc_pool_thread_init(serv, pool, rqstp);
>> return rqstp;
>> +
>> +out_free:
>> + svc_rqst_free(rqstp);
>> + return ERR_PTR(ret);
>> }
>>=20
>> /**
>> @@ -708,19 +724,17 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct =
svc_serv *serv,
>>   struct svc_pool *pool)
>> {
>> struct svc_rqst *rqstp;
>> + unsigned long index;
>>=20
>> - rcu_read_lock();
>=20
>=20
> While it does do its own locking, the resulting object that xa_for_each
> returns needs some protection too. Between xa_for_each returning a rqstp
> and calling test_and_set_bit, could the rqstp be freed? I suspect so,
> and I think you probably need to keep the rcu_read_lock() call above.

Should I keep the rcu_read_lock() even with the bitmap/xa_load
version of svc_pool_wake_idle_thread() in 9/9 ?


>> - list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
>> + xa_for_each(&pool->sp_thread_xa, index, rqstp) {
>> if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
>> continue;
>>=20
>> - rcu_read_unlock();
>> WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>> wake_up_process(rqstp->rq_task);
>> percpu_counter_inc(&pool->sp_threads_woken);
>> return rqstp;
>> }
>> - rcu_read_unlock();
>>=20
>=20
> I wonder if this can race with svc_pool_victim below? Can we end up
> waking a thread that's already on its way out of the pool? Maybe this is
> addressed in your next patch though...
>=20
>> trace_svc_pool_starved(serv, pool);
>> percpu_counter_inc(&pool->sp_threads_starved);
>> @@ -736,32 +750,33 @@ svc_pool_next(struct svc_serv *serv, struct svc_po=
ol *pool, unsigned int *state)
>> static struct task_struct *
>> svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned i=
nt *state)
>> {
>> - unsigned int i;
>> struct task_struct *task =3D NULL;
>> + struct svc_rqst *rqstp;
>> + unsigned int i;
>>=20
>> if (pool !=3D NULL) {
>> - spin_lock_bh(&pool->sp_lock);
>> + xa_lock(&pool->sp_thread_xa);
>> + if (!pool->sp_nrthreads)
>> + goto out;
>> } else {
>> for (i =3D 0; i < serv->sv_nrpools; i++) {
>> pool =3D &serv->sv_pools[--(*state) % serv->sv_nrpools];
>> - spin_lock_bh(&pool->sp_lock);
>> - if (!list_empty(&pool->sp_all_threads))
>> + xa_lock(&pool->sp_thread_xa);
>> + if (pool->sp_nrthreads)
>> goto found_pool;
>> - spin_unlock_bh(&pool->sp_lock);
>> + xa_unlock(&pool->sp_thread_xa);
>> }
>> return NULL;
>> }
>>=20
>> found_pool:
>> - if (!list_empty(&pool->sp_all_threads)) {
>> - struct svc_rqst *rqstp;
>> -
>> - rqstp =3D list_entry(pool->sp_all_threads.next, struct svc_rqst, rq_al=
l);
>> - set_bit(RQ_VICTIM, &rqstp->rq_flags);
>> - list_del_rcu(&rqstp->rq_all);
>> + rqstp =3D xa_load(&pool->sp_thread_xa, pool->sp_nrthreads - 1);
>> + if (rqstp) {
>> + __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
>> task =3D rqstp->rq_task;
>> }
>> - spin_unlock_bh(&pool->sp_lock);
>> +out:
>> + xa_unlock(&pool->sp_thread_xa);
>> return task;
>> }
>>=20
>> @@ -843,9 +858,9 @@ svc_set_num_threads(struct svc_serv *serv, struct sv=
c_pool *pool, int nrservs)
>> if (pool =3D=3D NULL) {
>> nrservs -=3D serv->sv_nrthreads;
>> } else {
>> - spin_lock_bh(&pool->sp_lock);
>> + xa_lock(&pool->sp_thread_xa);
>> nrservs -=3D pool->sp_nrthreads;
>> - spin_unlock_bh(&pool->sp_lock);
>> + xa_unlock(&pool->sp_thread_xa);
>> }
>>=20
>> if (nrservs > 0)
>> @@ -932,11 +947,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
>> struct svc_serv *serv =3D rqstp->rq_server;
>> struct svc_pool *pool =3D rqstp->rq_pool;
>>=20
>> - spin_lock_bh(&pool->sp_lock);
>> + xa_lock(&pool->sp_thread_xa);
>> pool->sp_nrthreads--;
>> - if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
>> - list_del_rcu(&rqstp->rq_all);
>> - spin_unlock_bh(&pool->sp_lock);
>> + __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
>> + xa_unlock(&pool->sp_thread_xa);
>> + trace_svc_pool_thread_exit(serv, pool, rqstp);
>>=20
>> spin_lock_bh(&serv->sv_lock);
>> serv->sv_nrthreads -=3D 1;
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 6c2a702aa469..db40f771b60a 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -46,7 +46,7 @@ static LIST_HEAD(svc_xprt_class_list);
>>=20
>> /* SMP locking strategy:
>>  *
>> - * svc_pool->sp_lock protects most of the fields of that pool.
>> + * svc_pool->sp_lock protects sp_sockets.
>>  * svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
>>  * when both need to be taken (rare), svc_serv->sv_lock is first.
>>  * The "service mutex" protects svc_serv->sv_nrthread.
>>=20
>>=20
>=20
> Looks like a nice clean conversion otherwise!
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


