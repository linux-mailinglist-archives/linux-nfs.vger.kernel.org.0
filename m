Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DCD617D88
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 14:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiKCNKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKCNKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 09:10:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1894D61;
        Thu,  3 Nov 2022 06:10:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3D4eJU014527;
        Thu, 3 Nov 2022 13:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=noVknW+oWM0DXWJgUEniwbyA+ADWcMVuFZOhGjedrBc=;
 b=BjOONbL37LIMsEwXo5QKGb6mLTVGfVpZg9egKN2jvBNXWKhX+LLgLHDc8kHEswNNh+Nu
 GH3V6aS5BIrXdBFLTox2GEw4gbBpXT4H8VlaV6qeWtKW2upEB7z1BBCCQdxhTIqoIh+U
 ELvjrpoRuBG/NOHRyRk3p7sU1T96+MqAXGT4hcLOwNGSHfZdvxoqxDPWju4yMZ0/i5up
 196GmxLMt5rkYMjCN5exc+WEg56qMlmlXA6598fGpL5NKyhzhM1L+b13tj4TNbl6+Hi9
 iDp4S9ikNMPpYcKAvuqA78qfvOjQJlRguHST9cC+uarWfooEpi6GtsX2DlEKBo4ZXbdg yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty34ra3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 13:07:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3CbJ0W029761;
        Thu, 3 Nov 2022 13:07:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm6kgwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 13:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHHWWEuD5TDLi6z54+a4XGYZauoJvdrsYZbveO8b5FTSkeceQM0FdivI60lKB5nNYHR1vxfSne7Sd7S8VPjL8JXqvJYnZIZDemP097qeYcgLGmPdNETGkxgvxUt8PaG3TRbZygtJC4QDk9ZfzcPV+ONhKqPsZlyHNHKGfui85DsqMGMv2suhGy0tdxpGoYemvZ5vTBLRljXB6djMaMolgAoZjzX1DJOjoVEtxZID6nMDZ62Xkcf7MQ6ZgZTcsr5ZTkvzGxWBg2cDgjwGKPEIGBFAfDc/DCflELCedPrzSVXpC8shUo+WwBoiZq1GSS9PzB81pQ7/4xgU62uhdgvUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noVknW+oWM0DXWJgUEniwbyA+ADWcMVuFZOhGjedrBc=;
 b=XVzF9/7K9HxDsF11zKFA5KjB6sDSMN21DFPE4NvIAQYMnnv7ZkYMFezQLnlIaXjr3p0+EPyOSjsK2RYEg04PVBgoxo5V1wEs91YeGerppSboxPYavBowmAfp9+5q41FKwkEl3pfChURDKmxCNnx0r1P1732yMVlZ0y8HPrRvSE4WS5roEjePrktyC4gAx9PNS9W3CR6JMFmJxVDlvddu8hP8HjVuSl+bAUWUMBp6jOeOMEIyeGyZ+754vkjzm6ygBCF+y8udD5nVX0gdq4ZzZxdFiorZNjHLpJqCw+mLLZ29TaQRtuBP8/vlzBGI9f+S1mPqtWiYgUtSao73fZCHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noVknW+oWM0DXWJgUEniwbyA+ADWcMVuFZOhGjedrBc=;
 b=ADkj24C9yAjzfOGjZyOocIeN3nfmaq86Di2dazuCpp3j7EMip4j6iKGkikrgbkd8mjDSCZDobgkO2zkrNACtQF70CGpUuCMdHWsowpXmNgy7H8y2RL75aJYhlFAjQs63tqUmlGIjm0YNtTxR9Be+PaByvT4wpUMIy9c7J1aDgmM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5136.namprd10.prod.outlook.com (2603:10b6:5:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 13:07:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 13:07:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Li zeming <zeming@nfschina.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: svc: Remove unnecessary (void*) conversions
Thread-Topic: [PATCH] sunrpc: svc: Remove unnecessary (void*) conversions
Thread-Index: AQHY7ySNZudTEDZRlUCQuYzh7drgj64tJx0AgAAFBoA=
Date:   Thu, 3 Nov 2022 13:07:24 +0000
Message-ID: <52658929-14AE-49AB-80DE-F0C68DD29D3D@oracle.com>
References: <20221103013510.3062-1-zeming@nfschina.com>
 <229b424a647bfbd18942eefef4cbf6332607ca2b.camel@kernel.org>
In-Reply-To: <229b424a647bfbd18942eefef4cbf6332607ca2b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5136:EE_
x-ms-office365-filtering-correlation-id: ad12c70b-ceac-43f7-48fb-08dabd9c5999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5NanRAoyiup2UGIqU4pprgKCPlIt0hRSfdBcwKILw86pc3DdZfXxdJ3rN9U7tKPPmU6BDGWDv0U4LinC4FYbpiL4aNPi4JP8rBn9Q/P0r4N1CoI4xB86GgPNOhldoz5S2dbz29W2kGIiTSygZQaUY215lvc+vC6YHtcWjfr+v2sKzvO5fnq+9ejbl92cplTZ/AgMg0gRrEMkWbX2oTg/3p1Gf+nxbe/PXi/JCf97Kgtclj7Vlx8DVk4dWXS6zNN0XNfriT+RKQlajBQLGK2wzgc0TOv+7N85P4Wk3DTkfRCo7WMbuDtMS36gAgEwDKBRqpRyWrLnZ+mwMeWwI8LDUohpi2t5bIEUydOZgtuhYoGPQ7hsOXVhvJQDEaQaTlZO42W229SV5+I5XtldkuFK8OP/M8prb0rSOIdKwxHscMBdZRgfLihg0uZZL0FPN/t+VTX0M8vL1UcspAns9eZZAy9KbDGynjHKnwPCb4NUKYIZsAfHasdpNt46oflt4UcBFzj6UUH56hoytJd/2IMRhM55jw7alSRKP6O4CU1XkdpyuiPt7oj88lCZV5nSr4pJu0jEJ0s9wi9MF9HzQ6/bRckHbQl+hDplAjBneNpGhhUwj26/5fRCTUIiJLUSdvTWPC6TzLIz8a7K7b0mSTlDbx4Bgrqsf1B5YtprHRaoZ0H7WaTdkIwmTUsc0tQWIf9CnHYj+wyZ+q6gGH3qmqC0CDg+5csnVlFXQmUxr+aa1gW4vJ7Ptir8cVf8sIMJtfUgxxCJ3ZB0QvJitZ3y/U+oss4uyPnuzL7BywHxMC2Mes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(478600001)(38100700002)(122000001)(71200400001)(6486002)(6506007)(86362001)(83380400001)(38070700005)(316002)(2906002)(54906003)(186003)(6916009)(2616005)(36756003)(5660300002)(64756008)(8936002)(66446008)(76116006)(66946007)(4326008)(6512007)(66556008)(8676002)(66476007)(53546011)(91956017)(26005)(33656002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TZiX/ahCfasZ6bIYweBLh/GTcIehykz7Czi+14VvL9/2PHOjEuv5ObmMsUQW?=
 =?us-ascii?Q?+jpSk/wkFxCxkvUtwwcqr0TnbqOQ4GFhc2xguLol/XfiVuXwNWKwEWZ8M62K?=
 =?us-ascii?Q?WGMy98owaV8RRy60WPJQV8fTceDeKAASXQ1mI5Kg/nLfSOagqSLuUq52GrnF?=
 =?us-ascii?Q?V1RrcLeKxgEfM63GxKxJCLKkKj1CK6rIfStYkSE6lZcVg0Y3rViTZ1bTRMnV?=
 =?us-ascii?Q?d6J4ITZktgEsXjX0Iy9me9tDJi//efJZ3qGGhTz9ERsgFV+p7C4c5EWr0NED?=
 =?us-ascii?Q?vSrftIaQT5C2cFr+OABquXyz9VsDnWH86dsW1zUC1iFsqOGgLXMN9u8gVD8Q?=
 =?us-ascii?Q?rbBpN3DM1Xm6gY+OYdd1fSv62BBZMLIXZOJQzF4nvq2JMBOPa5410J95ZntY?=
 =?us-ascii?Q?NtK+xtWKH6Rg8TwFyjNYEBcS4ApzRlvOEISb2D5L93KSUGXdaoVMWkMPQWE+?=
 =?us-ascii?Q?be8IJOFBhU+Xt6i3nIcHksn9Gt9RXQqM285qAnapjXnfRQ0VUIOLM59iCpPC?=
 =?us-ascii?Q?aM7uMY024DmoUfPVdvXZoNNhAmEuebufsUSYWS0pi4k8L5rRPNqLMoG2oRyG?=
 =?us-ascii?Q?uZ7dCzJ0R0hxuvpmhp41/5jGTHQR+lkZkgWH48EariCe6gac9jKW3Dxbwk5y?=
 =?us-ascii?Q?od9vW6AHH7dFcNrDupci+sllirAquQ/914pOG/fuE/fOe05daOzTj8zJlqGa?=
 =?us-ascii?Q?Np8GxyUYRD7GzgM7+bHNiXE1NG98KS9QiJJST1CvuGPK268wVPi+zgMOxuef?=
 =?us-ascii?Q?2DZbY2VG4YRveLmlZ6gs8iakYetkGD9j9zQNfWq+hx4epL1bsgrnqB2WL3j1?=
 =?us-ascii?Q?/zayVipexWgmRp0x9P4hWN1uI2GBjQE3KAZEtxr+bmqMftXzDQV5knRFzn5/?=
 =?us-ascii?Q?BWJT1ig8B/UAn95McJZpt41rOwWidHZ0vnEQ8VkoKRDRtL8lXZNqbJqAbuKK?=
 =?us-ascii?Q?O2cN9/Xv+nt1uQfrlcVFfGw00jekerRkBQzj+/pmms8VCUIqYMyVASqpikMs?=
 =?us-ascii?Q?msx14ugAcERwb3nDS0LmwLU9zRk8QJlQv3ZDwewG94oRLRoluGjyN4aV31Ms?=
 =?us-ascii?Q?ZmLLbBZ9vF7R1EJNo942ayUY2HKpl7KUCj+xomNLgAcnJDwIioyIaLRi+YCy?=
 =?us-ascii?Q?nWZIJ5it1wZm2sV2buIsU5EEb70RWa/66iK5tvYqP6fR4UCEHcrGfriIS5J4?=
 =?us-ascii?Q?SVCd42IH2vuAMxUqZTu6mUxTf+GBjNRrvJOMFVM7G1C5hFuiMhmMVLtCpxqJ?=
 =?us-ascii?Q?e5mCrHJDKWCXuYX2ruP+9Z4EDbhQcyDxo3dwQjrzS8MRy0RaYAkfuQTH7w/5?=
 =?us-ascii?Q?3irme8g4DIJ+iME5aj6xbQx0CPNY8Q27T8QHU+MGqQlb0oE/x8J410JfT2YY?=
 =?us-ascii?Q?6IT2og0+JSHe9Unb9mWCJ7YrQeyrHMQh3XT/hr25Jsv1qrj4raDhL4TkH7BM?=
 =?us-ascii?Q?aWpxlKXdtzqlD9BF3KIaV4+HGoWXiP9gVp1eaiphFYe23QQlzDOqJydcYYDC?=
 =?us-ascii?Q?rNJk9gTl5Wb/YqOcAGR5qYZJjbznDXCdZwk3K1zTyrztPLLmh40XdlSf5m9m?=
 =?us-ascii?Q?GmQXNASsnKoWIhXNZEjfMO1Wwok6wDCZeW5iCRv+JC+IQIBZqDbpRZSYtwxd?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0154365F4F71F74D87C92E39DBCB920D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad12c70b-ceac-43f7-48fb-08dabd9c5999
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 13:07:24.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2PFDUR8ggqBl+4T8mhVyfMkOWQ63vgzlQDsw2Z08pmXSZocHFWEKwb06DS319JPoJjlpqfsmDwA/NHp1ckORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030090
X-Proofpoint-ORIG-GUID: NHrYJjhLFR0Ra7Kt2iAOsN8e6F27FaSo
X-Proofpoint-GUID: NHrYJjhLFR0Ra7Kt2iAOsN8e6F27FaSo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 3, 2022, at 8:49 AM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Thu, 2022-11-03 at 09:35 +0800, Li zeming wrote:
>> The iov_base pointer does not need to cast the type.
>>=20
>> Signed-off-by: Li zeming <zeming@nfschina.com>
>> ---
>>  include/linux/sunrpc/svc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index daecb009c05b..4b0eead91c94 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -222,7 +222,7 @@ static inline __be32 svc_getu32(struct kvec *iov)
>> =20
>>  static inline void svc_ungetu32(struct kvec *iov)
>>  {
>> -       __be32 *vp =3D (__be32 *)iov->iov_base;
>> +       __be32 *vp =3D iov->iov_base;
>>         iov->iov_base =3D (void *)(vp - 1);
>>         iov->iov_len +=3D sizeof(*vp);
>>  }
>=20
> If you're going to submit a patch just in order to strip unnecessary
> casts, then why are you leaving the equally unnecessary cast in the
> next line?
>=20
> That said, why waste time "fixing" an inlined function that is not
> actually called anywhere in the kernel? svc_ungetu32() should just be
> removed.

Sorry for the delay, I was expecting an electrical service outage
here at home yesterday, so the lab was powered off.

So, Li, can you drop this one, and instead send a patch that removes
the definition of svc_ungetu32 ?


--
Chuck Lever



