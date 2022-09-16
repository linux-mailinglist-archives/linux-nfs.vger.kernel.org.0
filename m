Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75D5BA494
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Sep 2022 04:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIPCRu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Sep 2022 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIPCRs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Sep 2022 22:17:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7B74E3E
        for <linux-nfs@vger.kernel.org>; Thu, 15 Sep 2022 19:17:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G1wvDV004039;
        Fri, 16 Sep 2022 02:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tj65e7Qt4cs5Sa3+IZNEklVV3ipENSdyhb7jNKiz1yo=;
 b=l3ND8hdJTuXS/gQTPN4nhpMk3kXc1KhmUla9EEaD+D63FU0cSvCXOG7pZjhM8SOxo6Tf
 2F/x5ot0HpoJ5PEjXzDC5wZv+0RY5jiRVrCAhmGbcAqOdpkzioN1DrdLioIunN47sbl/
 WB7fNSXQkhUx3jaZLlORUlRCPTjbtYumK/NBSPpep9d8Ubtz0AhDlfr3GYceXFsMS2mu
 VJ/PehDf56mQ/VVD0/0jtx3uD5I99a+Bfkh2yyRwPuZiq1r3hV9f7j/S5vwms1twk43O
 4bM+ixGZXu1m2vxj/m7259lmqIuiDgify+BeB8RCsnTjURQgwXCH7r/jlVF7/YMKuVYJ bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xah0mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 02:17:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G0oG9T016171;
        Fri, 16 Sep 2022 02:17:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x8ntjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 02:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1ojj4tC1PdOKAX+3NzQsMoenbPDg7tHzIeERMoDFg3Ntbl+sFqAGl0JOJMRKz6l4uBOqJEb3dbVTf49d6R6QFLalZcbLWqgCvN/eQHt74L8mf1fiGH9pVdDnCEBNA0C5vLN8OwgILpcXdX28I9A/q+RTo6xUTPI2CrBriP5bqWM+aOOQX9UBrCxFBhSaEFNUBMYYrJDtbaToZ9uc3xmLUq9bzlA2bdVSB+sDsddhUW9Ju/KZYYGe2XepFqapLtPRkmwwnes3yQ+MmBgoZg2jJNr+JUzKD0TdwsMaxq77eujgCZJt/FZ9i6WmpZSInLsk8jBfmsi+PIZAufrHv9AfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj65e7Qt4cs5Sa3+IZNEklVV3ipENSdyhb7jNKiz1yo=;
 b=I7dx9q2Q/mGOmhB0/y8PgRI8Q5fDEGpGP8hBACflxcfjawgbzzWJ9kdOW/6FLnktcZpKk2U7r1pCHLZtEkdmbRnOaA7QAa/13ANmBsm36yuIVcB2zi9+Xsp3oLm6eUSn1f1RFbwtYsyU5JeZE2iqHUqIp5q/F8S/9iB5RiON1yJHFh14q5xBw373FhTXrSvlhxT6EaUM6cUfjRqotNCc21n3ltC3TPT8+g3hAuzbSyL09HBwB8Lw7PvJPtT7vB/NWuux6Ac22tYvLFQBUO7kMfYI0Wzfr1i2xOr7tDvLHoMW9NXR6bNuch1W1g6gqQp1NFQfdukq7JjUjKlGdzFU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj65e7Qt4cs5Sa3+IZNEklVV3ipENSdyhb7jNKiz1yo=;
 b=ZQPemnLoJBzPVQUIJRjPmtKNOLNrRuUL+EVY8/uSoKOIZQnn7TWgKhEgZDiteLg/FvsZmEjJ84yQeVOUvTctEl+aLJFyHdjIH8OPoYOdeDskHivzBQakqFHdgD4Cwemo3P2F4eguq/HNGr0jDGAMNHoSg3CMygVZkrq76MvUVHs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 02:17:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 02:17:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
Thread-Topic: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
Thread-Index: AQHYx5rr/lc8S5bVRUSZRf9utUmxSK3g7C6AgABplQA=
Date:   Fri, 16 Sep 2022 02:17:37 +0000
Message-ID: <394AE5EA-1F01-4071-860F-7BC113514423@oracle.com>
References: <20220913180151.1928363-1-anna@kernel.org>
 <20220913180151.1928363-2-anna@kernel.org>
 <9fe0c36d7d846a17aa65ace8df09f66fde96980b.camel@kernel.org>
In-Reply-To: <9fe0c36d7d846a17aa65ace8df09f66fde96980b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4999:EE_
x-ms-office365-filtering-correlation-id: 47de8c91-c91a-4176-d435-08da97899fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1m/Z5DKlAp6Fsp6jO4+FfsukVtCZCB8rLKqaLa3Pa4k/F8grKa1kWQVYp+UmevYi2eDFBiCxm9XsTEsSYcLx0yJgkaeuK0J8s2SZOYvV0eirznYJvzG6u1uGBEwsB/7AE6Tcbw6b0s0m+110tkVFEEXyR17Kc/pEF5fa7uMcsoxmbe4S0tHDmGst7O2WZNteBrc2P4nBlN5HvYz1E7BpOSOIPUL3+1GKWyxMMweUGbJT1ScYQl45/Jzmjn3/VfcKJAcapowqvrsGdZGWgHGgD3ttLwBU0uorJ9sduARKlbtILJYkAWG/D1KwR3AenWyiSeLbNOM2FSyqAJu27+jKqWI6tobyLQtJBnxXu7zYhmv221dsPHrc8VIUSuYsvEo+PFsrkTGWUdFW3TWR+eaFSLoeXlCtBDrvAby7iGedEIWQuPCs1elf6fDjpon6Hs8Bncja0wTDxa/Al0B/00Tpt5aSau35dgIxE4xDyjch4uR5euQ+nBlj92rTLUNEqiACty+Rfyf+GY4pJRtgi2x4GTD7wbGVPFvfotbj03Nt7oYaW1EGjo/mVQ+2hvhsvWN2cLF+HlBD4k6Bw7NBWeVuqekG6STUg9bIWBu3xlW/Tq+lf0mKbHK5NcSjjoolGblhy4mceXipw4FArFjTIyXg8wbhNAC9dttB/gCa8yBt4jyYjm6lEO54ZLzTyfEh47If3qZlmy0jWhb/iO1uQLUGwXJ+5IOk/crjStYmrPBI8uuz2Zd3isuWNz80EePTXzYDDNLyzqrNPSlFm1R3ncY3WaCvFgLpxdr9cd8eNlvlGo8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(83380400001)(41300700001)(186003)(8936002)(6486002)(2616005)(5660300002)(38070700005)(478600001)(86362001)(6916009)(316002)(54906003)(71200400001)(66556008)(66946007)(76116006)(66476007)(33656002)(91956017)(66446008)(4326008)(8676002)(6512007)(64756008)(6506007)(53546011)(38100700002)(122000001)(36756003)(2906002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o/KRH78fq9PpHKsXKgmwEC8cYzqod+GIgBvGCHv9Jtb92LDQWHBZcUdFmkTn?=
 =?us-ascii?Q?ikTugnAihnNLwOAmK8M9jasw5M5qX/WWwgOCWvuXfExTdxDxmuosmCCMvUqM?=
 =?us-ascii?Q?C+JxaOAwDxG8SyZZCgfZQBfNsRIQczKpORJlaHww7fkYM072ar5atAtoYqK4?=
 =?us-ascii?Q?Ln6u4EZ9C6VSc2ERacSe9m1vpLuNS7M0TBIEOCBLMWJZtZTssk3yTBQoEdRU?=
 =?us-ascii?Q?wHqzc7AlsiKdFn5G8F0ha/W5hLD4dS+vQzuznsCNvIWykVk3FXH0m/ZXKtKj?=
 =?us-ascii?Q?upzZyPBYpMjf63ayG95LK7ag8NFTC1zgukw2BQmK49p1CEA8Ytwv27TL3TF/?=
 =?us-ascii?Q?SFE5qqzTSo84WzGZCKaWuyAW723zCL3cQK9VLzGTBOeNsl7XXbJmoProecO9?=
 =?us-ascii?Q?W6Ix2t10miFt70PPaCmRaVFrISLIdhc1sa/09NMUBwh5iMKgKxcipqsf5Bk6?=
 =?us-ascii?Q?H2yoO5MnVaRDMYRIxhPKrvJ5+OQTMxMP9Pvprzc10bpyS1hzCCXxVAvA8kJ+?=
 =?us-ascii?Q?2XAR4W8IJsaNpDOvjHEVUZOhYje7T8mPHMgw5UuA32zaclMQfeDsAty7YK4Y?=
 =?us-ascii?Q?X8SWOmNEaa6u0F4YP5loNmRboeZzxEALqonrwE/9IdW/b/R+TXOsQiNE9PXd?=
 =?us-ascii?Q?S7rIvg0X+7FDhVNwBTZ9Cf9x+aLBjMG3ZKAbZ/FGJB3Sbertz02e7Y5DC8lb?=
 =?us-ascii?Q?BctinW2jZU+TBId4xRER43vQj3Sg4q1twQmAIIIj99hfHhCGSaIGo1lDez/2?=
 =?us-ascii?Q?Cd/vhF/N0oamoiBUeJRLkmw+jWqCswAYSrGK7X7ZdMJN0pxEvdM2+34v4RcJ?=
 =?us-ascii?Q?CAd2K/WKNU92UoFaX3pwA4X85vSMdnQHqM6R4uW09YaUM52LeJOZhBGK9OwF?=
 =?us-ascii?Q?uA3iXe1WZ8FsfUr5qtlkExmz9dNTHMgsppWsI18Nd0St8f/kPX+SvsRLz1Lq?=
 =?us-ascii?Q?a5XPFfoxQySphR4SjFfK74y60ucaMWgyQ5woKCuQHwbYGDOuTlVhx371Ndbv?=
 =?us-ascii?Q?EsYCuYDTYuK9XmpajMU5O1ekdEcZKCSxdT97Krqu15B0+d1oQ+qPa2BGoXJ4?=
 =?us-ascii?Q?ZP0tf9mFXHs1AxdZFAF1kExu8MblDLT4kF8FoDANPfJDgRFbJzkDgGYpgYPE?=
 =?us-ascii?Q?ZOXfA5CpWbFjCN3tXVBplW12PtB8x6Kox04/1nUzamL3fGUVN/3I9UpBwP/1?=
 =?us-ascii?Q?QUDP3b14keM9JDucs87GK11Iwq/P7V3EEf4BhC6hAv4cLDgJEaBOoFBOS0gC?=
 =?us-ascii?Q?IOlYysSeUWqlgahNRDYensCvMyt1Fz1kKDW2c4OzxaF7F5tsMHNhD3wU/FEw?=
 =?us-ascii?Q?r4MAnYxT8eUgxIMwUlE8p8wtPnCOh8UArT1gd8a3StsE1tanaErEW6BQsRe6?=
 =?us-ascii?Q?KD4x7ZX9jkhZ91drX7h3GF8NmGlPfi/GVyom2l+Z7U2Cjtyi6+rUHc1YD1Z+?=
 =?us-ascii?Q?bxb/+snmyQUSDX8/W5+xRK1IufPNZKDlOynqWYiUEoGbfqRukcA1H0dW1Yb5?=
 =?us-ascii?Q?uNrBi0EvUXbUpYrSsQJgq2NRkHaC3+jHT4Yeq/uXu4CJec+Giuy8YhRNZ+JC?=
 =?us-ascii?Q?O5kNuVyk6rxrdVbHdLa19OPESV5gfkEEGI7St0T+cf2uDgFVJoQz7Zd1dhki?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F1EE0FB6F898D488A786EB0C49E33D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47de8c91-c91a-4176-d435-08da97899fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 02:17:37.0858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hugc/NTl9/py2EVbxgXoOdrNmGH5tCMNWL+zVUfN09vZew+WdC4RFHbyfE2tJp+ZPVKBW7turNfVWkk5rFO6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160015
X-Proofpoint-GUID: 5KuxA1Jg76O34xGOf-B6Zq468VRV4IoL
X-Proofpoint-ORIG-GUID: 5KuxA1Jg76O34xGOf-B6Zq468VRV4IoL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 15, 2022, at 12:59 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-09-13 at 14:01 -0400, Anna Schumaker wrote:
>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>=20
>> This was discussed with Chuck as part of this patch set. Returning
>> nfserr_resource was decided to not be the best error message here, and
>> he suggested changing to nfserr_serverfault instead.
>>=20
>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> ---
>> fs/nfsd/nfs4xdr.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 1e9690a061ec..01dd73ed5720 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -3994,7 +3994,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, =
__be32 nfserr,
>> 	}
>> 	if (resp->xdr->buf->page_len && splice_ok) {
>> 		WARN_ON_ONCE(1);
>> -		return nfserr_resource;
>> +		return nfserr_serverfault;
>> 	}
>> 	xdr_commit_encode(xdr);
>>=20
>=20
> IIRC the problem is that nfserr_resource is not valid in v4.1+. Do we
> also need to change the nfserr_resource return in the if block above
> this one?

I discovered that nfsd4_encode_operation() converts nfserr_resource
to the status code that is proper for the minor version that is in
use. We're good to go there.

--
Chuck Lever



