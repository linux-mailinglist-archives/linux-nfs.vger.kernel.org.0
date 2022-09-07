Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCFE5AFB5F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 06:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiIGEi2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 00:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGEiZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 00:38:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD28C03F
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 21:38:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2872xGRK013987;
        Wed, 7 Sep 2022 04:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=27gu4jkyFWClwQaevA6r9bVyD55Z8PYJ0HBSKkdeGq4=;
 b=dNS1Yf/VvdWLeudX99aAyB/YSM+fOlvmRSzXaTxfmFCgiJstohvkOedv7+wTZYfVNR+W
 +3jfFL2m76xcZZ3hoXx7xKecQQNw/WIi8qTr8FmZpJQctDciOOROYUNl93iIqSpibNRy
 Y05uan3hNXKOXOJKRqrqYp3ta6mgzQjA/Hrvr9gK15R5p++uvYJ7SbC0UykidDM/ggZ6
 tVoWpqPIDGJ7UY9n9ZEMNBllWSJZS0TjAligUOyvsbtLj6dFshWlpLEXGxsIxTsOB7UO
 cF3nfIx5L+QxEYey8+zshhy2F60zx1RTw5UPylnYMxOXKF2cWhFE/LiRyP3sKjbKuHHP 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1fqxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 04:38:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2870PxXX031243;
        Wed, 7 Sep 2022 04:38:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3raub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 04:38:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbyNWLa0NMbdoQTX796S0Es6GIbQHu66bYkOSBgvIcvvj2lH4fuR6Qou32Lm0jDgWWZdJ4s/39Py9XLe5WFgq8Ivus+SeP+U/nuSXNVB+wjyJ0fqsp4pSll/Tmi3clLRkbXVbufRPiHZJbLVAdFvM38uwb/etykXDvsMN2cCJXtCH7fsLBGCE9dVPn+MKGs7PF9J3AD3T+2fD2dvTioATmVNK+ig4qcnx4IugFgzJ5jLZGytewLOsmPMGrbuMh1nGvcmFOqRqukamUaqUe+XM1GQcK1U6Q8wEZmOUMGPpYqTKSbL1ZjcNqtePTXg61Li/wyvaPhe+a3wM1okFb8MvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27gu4jkyFWClwQaevA6r9bVyD55Z8PYJ0HBSKkdeGq4=;
 b=m1Eh9ak/MbP3yGwZ3x2skE3dh2vZABJP5dsoHqaYnbaqk5te77FsbFLt4aLgK9F/esc3Xfur17l9HFqk50CBN/a/EeyX2GHYBPFqX5sWdnDDnuyUI06TVmbk1hsrmEPJZFjkUmP1IjRgKiMoecdcILxhKX2mEHxD9IVONjk8dbtpOmGqpy+RC4m+B0wMcSEVUhDUflyPKzDWws641hCuQjAkjOktR0qwPCBRDGr6m69y73s6l7zpNWCnhHgkSC5q097CcDFY+tiyNNtPbsSegqM2nWbE6ajg2ypUX+H0hrbHj2Fjb+bChrG9ozmiRPf6SfMRwHNcNjzMfBjoj3Gy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27gu4jkyFWClwQaevA6r9bVyD55Z8PYJ0HBSKkdeGq4=;
 b=OIIyG/lacmg3MSUeiAs+eazNp9lZzopyvdu6OL+5MJLMcXTOdk+78jZVcx8LLOwaWfnJ9czB5PDVZtVdeNyYAMzdlzf7CypVjU4mDdyDp1GdSKctgx6QJA5RfDwr8PjxgjkyYuqsNfyLtMA6KXtF0YrO4we10/lHabla8PM4Ppw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 04:38:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 04:38:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs/001 failing
Thread-Topic: nfs/001 failing
Thread-Index: AQHYwUSkLMMEn+4AHka5Hmq2SfLVB63SVXMAgACz6ACAAFtmAA==
Date:   Wed, 7 Sep 2022 04:38:17 +0000
Message-ID: <75E3A557-67FB-437E-8350-D2ED82ABE4B9@oracle.com>
References: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>
 <20220906122714.GA25323@fieldses.org>
 <166250586898.30452.12563131953046174303@noble.neil.brown.name>
In-Reply-To: <166250586898.30452.12563131953046174303@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5202:EE_
x-ms-office365-filtering-correlation-id: 30edb840-67ca-45ed-b3cc-08da908ac895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7vUszg6kO7+no9qlawo9kpFW19V9muuBYZ2uTsWk0xXUsdiSOi5mbIr4B1P0bMD0QpCCRAc8BfvH4QHPMNW8W5jT1t9AbSePl8PKafiuDe3VmFAX3LujI6vyZJviZeQCECFDJQj3Xvy/ZO4af7XujqI2g5nVWFs9XEvK4PtJOubXdQPlaNEjGqGhgZRnoy1Lb+RG0TV/82VmQ6kJlkOzZsIMTZeUag0J1hJFXiotZuDFPXSQstT8Bh8N3iUZu+uF5K2e1cQa80br29MULRgKC0THxklgYyP/g2gSGe3UMLGGkRI5pSkmTd/TrcwWowkDoJuH3a9r2IVlTPWUcUbNThu1rBSZQHwdh3TR5PXzG/FuE6jXHjAWwOqRHMPxqcjZcZdkivpoB6RdRRkgmawX8wA3vhhWn6g/6ynXPnBu9XztKHBhSUavf7TSE5Y89Zcr/BRKU0Pq6ceb6Lh3JMXNLx+XiQRBxipcfUjvMDpQpK7VideMI9shUD20wmlgLEE4xCFK9QRrhPpjwuwa1iLdrJ10IDF6Gd/3Jcu9zilLgoWKiOfluSDpx1R0rsbcUHvutM2VMba8TOL0lk7BIczX77hn5/QlFqJ6FmwUXFYt6pT5jQb9ayt+4u+1uZIXIHGYFIg2nsqlYa/Qb/Ttlreq60W0dLIJ/K9VttaIWVzKRh+xjiRtHSNxrKPDX9uy5ysarYVHDaZ/AiMJkxA5PnXU3cBc9Kv+blfI//sIrKqf43OB71s2o9KiPhRodOQNHSHAScvtL/MP/N4r2pFfkhclrEk5uMMhpIUPzRiZufrXM+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(136003)(396003)(346002)(186003)(54906003)(71200400001)(2616005)(122000001)(38070700005)(83380400001)(86362001)(36756003)(316002)(6916009)(5660300002)(8936002)(6486002)(76116006)(66476007)(64756008)(66446008)(66556008)(478600001)(66946007)(41300700001)(8676002)(4326008)(91956017)(38100700002)(33656002)(6512007)(26005)(4001150100001)(2906002)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ip28yehrBOK+zKQ19HGkGutBZ2iOgEXPj4WDJo0To68MGednzlth2xTEoxym?=
 =?us-ascii?Q?uzT9rFEg/Ey9yZMhE+H8x6xTvCKEBZF/bu2bf+zjrG99rQKT7br0joYlh1Jf?=
 =?us-ascii?Q?quHrnxHT+G62NRFl7+HBvCiFP6VCXXgr7svlJeh+Y/UlZ8oqoqIH0FIYFLbY?=
 =?us-ascii?Q?XrCNEZO0sr3xWhDzIKqg8FO8MNp2pNb7pGflafE/rV0IZ6hP5cmmXSYobD3+?=
 =?us-ascii?Q?Rf4Eh1Q2QJQcoFSHYCJT0HAlh2fbIeQ24vZft3LJHSYw/3GCDaPzqOTJTYuI?=
 =?us-ascii?Q?vex+lGT9gNSGnO/wY6FjLXhVMqkS5IUhAAQ0B94AgCmdivrznT2pUJibXfva?=
 =?us-ascii?Q?OedcjCWFk7ClRRRZg5+XOvZphHDaBWBiOyhqq76PlzBS+C94GfNn4d/SlGeC?=
 =?us-ascii?Q?I2ljNchmpjSwNdoxSv8ctEHZV3zsv0ctVsf7ejUh386s/2RUl+l/R6Jp0vEs?=
 =?us-ascii?Q?DrHssx5gMBgzxsHLmfZhk9XNbflaMacvUz0Vv//5O2VC0XshOw3jW6t0d5hf?=
 =?us-ascii?Q?S4ClO3zeB4GmftozKazzcg0NmQH8xeeQ6kTfbr3eiCPl6ZBTpKWSQ5affs2j?=
 =?us-ascii?Q?ZQADAaZQ9pGm66I5ezwG9nt0JeN2OHsZiuxr7sGUAbwPZakS5Tq8fjMQyCkG?=
 =?us-ascii?Q?3GO6uvlvD6mb09YIpgYeSPHq2lDYuNI1Be1CqfXgJpTH9sXt2sh7Rllm3y6M?=
 =?us-ascii?Q?uA1qIpRPsFYmSBkXRLK3xDwVGoooxsnintamVPlHw4JmGhpNP2g8zbCqBzSh?=
 =?us-ascii?Q?W/frqof90YHje5aOmk+dnpb2f8I5HzcOYQT1nW2aFdXWCZrD6bW247pOS+SH?=
 =?us-ascii?Q?1HrGxsDpSX+eGSFUKNvpBv0jhWq5AXRRZ8AzLxJAGhJbj4XpvJ3TdvsOI4i9?=
 =?us-ascii?Q?AL81lAfsD224TF4K3d2uvhmJmup191B9RDB6dL5gPXdq6H6FlNJaJzzHFZ9R?=
 =?us-ascii?Q?uzIzlQWvK0jAn+jrWKh402Vtpb+OA/up0zcHd9/3EcI0ARdfpNsv2MdofMDi?=
 =?us-ascii?Q?GpD+TTa4187J9CPH5tXxIAXTjZxwZFwdYKqGmd8S0Mn9b+E4EETqv/NkGA7+?=
 =?us-ascii?Q?yWLHHdlP+UrIq8mQyze9oLQPETLd7Qy+JuU0xgFvoPmcB2ZQrA8HlY7wDksk?=
 =?us-ascii?Q?6aIl/UtkuS2mrJJ2GPSlluG/W+WrWYNsxldoC06so2yb4Q/vX5DaesCPT/6E?=
 =?us-ascii?Q?jJAPmIf/Aw5ab4m8rV7VQT1Y4LTIBNPj+AlycfjXTMz9zQmde7s8SNMAjKwg?=
 =?us-ascii?Q?/8d2tD5sVlGuXz7lHa9/xCi1Qsc8oN9i9OFAPLpYXmWQdr2v25TNqtOew3tb?=
 =?us-ascii?Q?5RrxWSv/RFn1Y0vvZdh29VM9A8PD1c5vDnWHlmMxxOUW4lK8kITw2udQLNeH?=
 =?us-ascii?Q?DsJhtNxPKzbpiLjn+RhzsewreZ7EHUsZ6TyY2fg/a1Xn01dSrPN/zArnX/H3?=
 =?us-ascii?Q?bxw68aU/LSvnIAN46Two4L224/Pc/Ozvc58xnyTz5GvcGhyGJwIHi9VL7wJc?=
 =?us-ascii?Q?oS8No+DE7kfViV/i+XXmh3Fjs93XQTczAF5BXVvlcjrGOOhffNPCDxN7LLEQ?=
 =?us-ascii?Q?cUNeDo2Xk5PMSRfx7ARh2nvdWkF/dHBeS6PgvieHU46n+2DPRiexzUGOjZHW?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCAD8AF8F17D724C82C2853CD4E035A7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30edb840-67ca-45ed-b3cc-08da908ac895
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 04:38:17.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzWfyqYTjTPXUMLK3iJb7a0AivEf4pST5QaNUg7WHdkDl2hqsjQpQcxqTLUB6ovXxdH1PUJwN5rkGii/QETkIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_02,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070017
X-Proofpoint-GUID: t-GlR61ZX5-Xc7Oh_FadxebroVdMQ8ef
X-Proofpoint-ORIG-GUID: t-GlR61ZX5-Xc7Oh_FadxebroVdMQ8ef
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2022, at 7:11 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 06 Sep 2022, J. Bruce Fields wrote:
>> On Mon, Sep 05, 2022 at 04:29:16PM +0000, Chuck Lever III wrote:
>>> Bruce reminded me I'm not the only one seeing this failure
>>> these days:
>>>=20
>>>> nfs/001 4s ... - output mismatch (see /root/xfstests-dev/results//nfs/=
001.out.bad)
>>>>   --- tests/nfs/001.out	2019-12-20 17:34:10.569343364 -0500
>>>>   +++ /root/xfstests-dev/results//nfs/001.out.bad	2022-09-04 20:01:35.=
502462323 -0400
>>>>   @@ -1,2 +1,2 @@
>>>>    QA output created by 001
>>>>   -203
>>>>   +3
>>>>   ...
>>>=20
>>> I'm looking at about 5 other priority bugs at the moment. Can
>>> someone else do a little triage?
>>=20
>> For what it's worth, a bisect lands on
>> c0cbe70742f4a70893cd6e5f6b10b6e89b6db95b "NFSD: add posix ACLs to struct
>> nfsd_attrs".
>>=20
>> Haven't really looked at nfs/001 except to note it does have something
>> to do with ACLs, so that checks out....
>=20
> I see the problem.
> acl setting was moved to nfsd_setattr().
> But nfsd_setattr() contains the lines
>=20
> 	if (!iap->ia_valid)
> 		return 0;
>=20
> In the setacl case, ia_valid is 0.
>=20
> Maybe something like:
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 528afc3be7af..0582a5b16237 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -395,9 +395,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> 	if (S_ISLNK(inode->i_mode))
> 		iap->ia_valid &=3D ~ATTR_MODE;
>=20
> -	if (!iap->ia_valid)
> -		return 0;
> -
> 	nfsd_sanitize_attrs(inode, iap);
>=20
> 	if (check_guard && guardtime !=3D inode->i_ctime.tv_sec)
> @@ -448,8 +445,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 			goto out_unlock;
> 	}
>=20
> -	iap->ia_valid |=3D ATTR_CTIME;
> -	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> +	if (iap->ia_valid) {
> +		iap->ia_valid |=3D ATTR_CTIME;
> +		host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> +	}

Unless I'm missing something, host_err might not be initialized
in the !iap->ia_valid case.


> out_unlock:
> 	if (attr->na_seclabel && attr->na_seclabel->len)
>=20
>=20
> Does that seem reasonable?
>=20
> Thanks,
> NeilBrown

--
Chuck Lever



