Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EC75099B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGLNaS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLNaR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 09:30:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D509919A0;
        Wed, 12 Jul 2023 06:30:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6T3HY010900;
        Wed, 12 Jul 2023 13:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KUVkW3wvxCD7Vhqjqdtg8dtD1DXj0fbUToFOp6L6kPo=;
 b=roLnZ02KwC+2ZcGKsm2O5ImRg2gN3tV+Y+y1Y4imKr0DVKObMSLW6hybqZWfyCtbU58t
 WCVqX26ERXR5kU9X1VyviE67DmQnaFD1z2K4yU3TZsAHJfUlBqGp4f5+q1mFOWvIAysW
 sVTOo8ep8mIIPMe9naeVVEh7k7yytaZNJ8drtGuTvv0nllOqX15wHvUVdPs21rWFCjOP
 0TKB9GtoVv2hvk7e4X7uDWxYePNGbkHbLHZH/ro4GIu+cS5VuM/wtucNO+oOXxoeHQHR
 oSSda/X3TIKJRrsj2umqG2Ar1vNvrXcIA+Qt0AWzqnZ6tONRx8R0dmu0EN65yBQmt0nP tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj655pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 13:30:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CDS80U026958;
        Wed, 12 Jul 2023 13:30:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx86k2jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 13:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXCfo5RBva52WdvmrhaavRDNr0V5NqTDJJtsveXyQmt6+QTyumXw9Xv/BhsMkvFjgg15EP64qYo7TLcaJScSHsQkTiBCDadSCyQIvPOPPOFyoKQNrnDxmlGW+sAvxWMWmlHLSJK+fFfH3ISHPTJGtTIMBBlBYeM9y/u0Z1/SY0TlxULDDeShwV00W7DG86lp3Ok5jzdXO3teicUtygQmYUfmrdXg1tbk7nAoTKg4tr+xbKhOWUgT/b7wwueyZFOdq5YGJMfFGDKgBEVjvMdhS6Ay+2yT7ZotJewxqxKG18oP/7odfAblEmXdQ7zyRyQQwa/yCgSA/wPlFhF6xOyzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUVkW3wvxCD7Vhqjqdtg8dtD1DXj0fbUToFOp6L6kPo=;
 b=My+JR8pC1oOKJl7uXyu6sQhkjCWDs8OL8swc2ITJ8jKonEflXsP4ghmTsXqKXiW4VrJC0NuzNJ+a3O/Rcl5G7wM6lOA4JEPpq4IA13t/4mP9SL3/9rlSCR7+3r6LJgjvM5VZYLcYxJpFmiKnGJe1BoaWTjQNTbfnAEJHrrQNqwSHMkMXiIxapsz8ERrbwvMhwTw30/kTRpXm1V6e5EvVNJh8dZeFo+yOTTBL63seEIcZlR2zBpTpl6TUP8aupkK3fA2d+OMg2Y6T+Xhb9/+huQYeSg0TXFlQ9zxpzMLKIsakek7aGXUg2qEUG5dI1sX+8TWJZizYcttzHAbGnrOqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUVkW3wvxCD7Vhqjqdtg8dtD1DXj0fbUToFOp6L6kPo=;
 b=SMsv2F4k5nsHnhRteSVXBUCzIwowYwhpW0GCfdTIYsK9/2FBKjCTwRjJpEdemdrNx2znlCJzDMfWJQG2giH1QG6KqdWrgyJCIx/nt9OyR4GzjivxAzmozUZ/PlN0MIeyBz6O4Hm82McNWv595q3bZnAh+K50poTu1nfZGQX53dA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Wed, 12 Jul 2023 13:29:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6588.022; Wed, 12 Jul 2023
 13:29:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
CC:     Christoph Hellwig <hch@lst.de>,
        "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Thread-Topic: NFS workload leaves nfsd threads in D state
Thread-Index: AQHZscpE2u3hRnymrkaAkGCGMx38d6+ypIIAgABnPoCAABH/AIAAJpqAgAADUYCAATOkgIABit2AgAAgGoA=
Date:   Wed, 12 Jul 2023 13:29:58 +0000
Message-ID: <92CC9151-0309-41E9-920E-A549E2A73BE4@oracle.com>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
 <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
 <20230710172839.GA7190@lst.de>
 <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
 <20230711120137.GA27050@lst.de>
 <82cb9937-bd11-64a9-2520-bf3cf81ec720@linux.dev>
In-Reply-To: <82cb9937-bd11-64a9-2520-bf3cf81ec720@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6030:EE_
x-ms-office365-filtering-correlation-id: fa06a740-3573-468c-8ab0-08db82dc167c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khUO34EY8P+r7brJe6uQF5Nheycx/tjmZDTLes6ZfJHO1MoAbSutEzu1OseIZvLO9JwcL1bm8ih9MC9veBqeG/YE51At2VHtD77cAZlx+K/EyYr6Ytg2y6sklt8ZeGQqPvGkau77hm6OkslN0RfriFG6qcyQT3YsTSWsqX5+rAKhZdKP4r/pHQYPUFgb3eH262bmGZc66Tqb7/JkjcxtvAo5JtK8rItbNA3RF4/BtTZ33G6D6lCmiae45dHO9Mf6dImh2OFm8L3D9h35LW1usS1rktmMmw1u4EG/JL/cXR+rsHb+GbQb/JxwexA0Tf8W1wQ7V8frwxkQSNaeTxbCkjcXharPXgZnIfRxbYyipUDNKcnjPWK+GQEcmXn2wB3RVi4T2tNks8SYd2XvCifJG6SaiFX4nbWKDJKi5oXWwuiGaR4AQMG1kU9jIaxFpvCJ5U/RTOO6rychnXothvwrrCTXfQ+TWDUB1OZ9ZDcW/k5olflnJqOcXDvYaSbURis1ibfPHw1lkkQL4/9914OoDH1nyYbC2VpOP+dkblT7A1VQx+rIJRQhF+zQAPs+JSOjWzcnCG0zsYrD5qhb2DaL3A9ZgmrrfMxmzbACzxi6bbJqEL7wRu94XrY4yzBT2ww84cHaGT/FM8ihyCq9CpJGAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(8676002)(8936002)(41300700001)(54906003)(6486002)(5660300002)(2906002)(316002)(71200400001)(6916009)(4326008)(91956017)(66556008)(66446008)(66476007)(64756008)(76116006)(66946007)(33656002)(478600001)(6512007)(966005)(36756003)(186003)(86362001)(38100700002)(122000001)(83380400001)(53546011)(6506007)(2616005)(26005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lteX387+yF75CY60oAY+1C1D9QSs1i1ZbbMqwTzoJXjAcWVEuzrh1iBMVzT6?=
 =?us-ascii?Q?2kLHuyNLQWrycAqYsh/Wkd6Af/doekeXIvQytmzB4dyW5qfiZPXcZ+EDlMhN?=
 =?us-ascii?Q?TCxOf55dShbTSR5W/NjTVe0S+AG4ync8JBo6iEBQJ/fbmE6IogTW+kpNAWBP?=
 =?us-ascii?Q?kWa703VfJCt71s70yk0+WoH9Uhiy8m+1uUMBl9VRPk/m4ghLgNRDotOyHNRR?=
 =?us-ascii?Q?Bpx93JYFaBZZevFs70zgUjX2koPyLpgznmurvC0p52E+TwrEPYO7Piydw+sq?=
 =?us-ascii?Q?uGsLG3GPw/XiQYnqa7kcpsy/9A2cUpdCZaO3vFe9i6oFVmS6RTs2TtmLdYIy?=
 =?us-ascii?Q?NBs43M5YF5ay6nR5LswzijCxr1uNVS3mBBKR/vouIgmOHtSKQASAIORB7p7I?=
 =?us-ascii?Q?B9kUxRGs236gMBWvx1P789siMS6yX00+msY2OoWnExNIgq10g/AUt9D5HHPd?=
 =?us-ascii?Q?Psxy8X4iw48UTsHwPajWlFqwV8GxKW/L5RI+m++lNCJXQqeiLZhfpkpPPYzk?=
 =?us-ascii?Q?qZP/KY4COfglwb4n9Suv0HbtA6DUv4PeeMCW8PwmE/7ayjRdSAMyfPJnhm9n?=
 =?us-ascii?Q?qCNHy66Ehj1T7tMmb2ox31ZD1bKtbrnYN7xIbKEc0Vw7aQ9Qq8oo26QXxic2?=
 =?us-ascii?Q?YaLBraCRq4l8hR7rlMTdYgT+Lvd7U1b2gV60RNGuuHeuHgOXnTdVZ9iHxTo3?=
 =?us-ascii?Q?62FGqdasZdY14DXfGwKuhU9TWKn0xX4nkZv5uIoPG7Ib1ktSByL26Icc7ThF?=
 =?us-ascii?Q?2m7FM9VHFrNSdOrwub80+cY/+Jx7n+ukxlfJx31Lbgmc8p005dDwIoFfbP8m?=
 =?us-ascii?Q?AMMz4c8lKyCSG4A/ir1NvSEU0+u/0fY0c9l36vSkaOhHiPlkY3W8pOC1zl9y?=
 =?us-ascii?Q?E50/EJVxtEp0eQSrFh1m1t7KNYpwSCDaCnDZnrhrM7cHMvde2BrMBDsj8ulR?=
 =?us-ascii?Q?6alb8kPy16f+mBwldpZcuHOI8b0XdBIuAfNIyctFlSf35sRFSl8fxRoqOMLm?=
 =?us-ascii?Q?So5wVOV9LETYkjJtf4qKNZg9Qyw/IwNzMeXbO5JpPESH5y6TdEhCFreYRySP?=
 =?us-ascii?Q?i8TOWnN/bm7uy45Af6x7ig68Bzk/FtgyI+ho5RswrKFfwNL3NZg+tIPqdtmE?=
 =?us-ascii?Q?8B5mOag26gryMea4/PN4rX+jPqZ+NBBODwPIZQUUj7ng2WQFAxVGlsZGbxzh?=
 =?us-ascii?Q?ZloT633MtcreVvPLp36ZTKaF1wDIYDJFGgYVL6aVeGk7lfGutg2ovmBdZsMv?=
 =?us-ascii?Q?8prCc8PzAddsR00J5LKo2WgThbNebzzU5COT23QiLIrrY5lGeIUB4FBu/biK?=
 =?us-ascii?Q?2rW9ugzu70WncSVoN+LDN1hKR6sF1Ol9eJlSXyrDLXFAjuJgZXlamzY6HBZ9?=
 =?us-ascii?Q?OOCueK+GX6RtpQUfjhTD7DlHbuhe/cd4mE6+2qoWeENJc0tM8wNvX7kO0Vi4?=
 =?us-ascii?Q?klywcLX3zSMa/1Yctmt1GJ/meXSVMqUu6u4G6lJz4fSgHYF6kgTf6PJ00JdA?=
 =?us-ascii?Q?bjTJKC1PHKAfXrChqTwoHpJff75kCZOvvqgyRn9ZT2JrcSHpk17PPYko4vGG?=
 =?us-ascii?Q?ztrvk0qzaHYsS7RWjWqrF/JN8EnWFt0i8boV/X8+PBFQSimSF9OFDrgNBjst?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A6D2A10B8A9A44BB9E42743B75DCC16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pLuDCPnwN6POMn8ahJB1pJYgNQLK6JkTTZqJDa4hM4NGHIFQ1HwMsgefHYRyCgcJyTeqTWpXEfZ6XwXA0TViNz0PvoVYi+TBfJIf7DRvJxwmgFxW/buzJHvmE8J0FplN9E1DPHokrtOGj2BF9XBNSa1kiTJNth0+OJhtF3HQYOZrMa1UPZodpguzQnAwEwx0sVBcvJ4A/4Oo463yXifCziM2APG6ewa9uuW8GvWaYFzeU6wUiygAheoER1iVjN915iQS2RAXZIHWhs3nMKgH6c/IwYM7W3IhEmXeO5YRNL9oDptbGvwwE1Ab4DQfDClHCx3Cftv8K/TMMEhS87B4KRltkcjhUKgv8lG+BmciQ1zY3xbIiQeVF8ZKXuD588M46mpoJUwrOHye2gnSNwDgflSioeruRqQkUlRqZ3eOQaj7a2MrdZiY/AG76BIrWp4ewe25ovNYYr/wyY4tcm4bSIn+4YjlRKSZtSmD0Vb350Fjid6zk7BuDc/zP/ZK3zPw5+MaEiiWT4/T42DK0s3dwZMOA+qXzBoQLTl0feZyJ60o09tnjWQRppVRq7d01WfawFZGyI66GMbRx+qPONTyxZ7KPpOSSq9KUI7FSO9DChaQPo6PAFz/87VINbkExYRLmbg6asDAIT6zQDOpNM/hEQMnyf1nSPrv2GwoTL9iMdanvGnJttujdwxHE/yES8pcW8Vn1ih9N8lRwnTZNeorGjSsuiN1ak5nHw/S5AVJbjbnyqyCk7VK1uK9qWVneR1u4oXpoxrs/Eho/2dMflfTuF/whe2utKHU1Ar6JhRBk9pcf7ygFrUdmMx6RMjxnJ5VMp4Yhbnvr1QqOVPzaCCp4O1LBW4mjxzwr6Y6MnMU/f8q4948UBnXo9W7EGfJYXgFvFgeqpA9+uShPHQDPCaz6g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa06a740-3573-468c-8ab0-08db82dc167c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 13:29:58.4608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7cwUfIafuL2CubgZVu5JXmXykwgbREsF3eNQQncYm78ckENPb+Av/7vbpKwoYVarG5hpxnzpkuARPvTi51F3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120121
X-Proofpoint-GUID: yLlmG5VOUAZmfvpfehFIivijpUN43dwP
X-Proofpoint-ORIG-GUID: yLlmG5VOUAZmfvpfehFIivijpUN43dwP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 12, 2023, at 7:34 AM, Chengming Zhou <chengming.zhou@linux.dev> wr=
ote:
>=20
> On 2023/7/11 20:01, Christoph Hellwig wrote:
>> On Mon, Jul 10, 2023 at 05:40:42PM +0000, Chuck Lever III wrote:
>>>> blk_rq_init_flush(rq);
>>>> - rq->flush.seq |=3D REQ_FSEQ_POSTFLUSH;
>>>> + rq->flush.seq |=3D REQ_FSEQ_PREFLUSH;
>>>> spin_lock_irq(&fq->mq_flush_lock);
>>>> list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>>>> spin_unlock_irq(&fq->mq_flush_lock);
>>>=20
>>> Thanks for the quick response. No change.
>>=20
>> I'm a bit lost and still can't reprodce.  Below is a patch with the
>> only behavior differences I can find.  It has two "#if 1" blocks,
>> which I'll need to bisect to to find out which made it work (if any,
>> but I hope so).
>=20
> Hello,
>=20
> I tried today to reproduce, but can't unfortunately.
>=20
> Could you please also try the fix patch [1] from Ross Lagerwall that fixe=
s
> IO hung problem of plug recursive flush?
>=20
> (Since the main difference is that post-flush requests now can go into pl=
ug.)
>=20
> [1] https://lore.kernel.org/all/20230711160434.248868-1-ross.lagerwall@ci=
trix.com/

Thanks for the suggestion. No change, unfortunately.


> Thanks!
>=20
>>=20
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 5504719b970d59..67364e607f2d1d 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2927,6 +2927,7 @@ void blk_mq_submit_bio(struct bio *bio)
>> struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
>> struct blk_plug *plug =3D blk_mq_plug(bio);
>> const int is_sync =3D op_is_sync(bio->bi_opf);
>> + bool is_flush =3D op_is_flush(bio->bi_opf);
>> struct blk_mq_hw_ctx *hctx;
>> struct request *rq;
>> unsigned int nr_segs =3D 1;
>> @@ -2967,16 +2968,23 @@ void blk_mq_submit_bio(struct bio *bio)
>> return;
>> }
>>=20
>> - if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
>> - return;
>> -
>> - if (plug) {
>> - blk_add_rq_to_plug(plug, rq);
>> - return;
>> +#if 1 /* Variant 1, the plug is holding us back */
>> + if (op_is_flush(bio->bi_opf)) {
>> + if (blk_insert_flush(rq))
>> + return;
>> + } else {
>> + if (plug) {
>> + blk_add_rq_to_plug(plug, rq);
>> + return;
>> + }
>> }
>> +#endif
>>=20
>> hctx =3D rq->mq_hctx;
>> if ((rq->rq_flags & RQF_USE_SCHED) ||
>> +#if 1 /* Variant 2 (unlikely), blk_mq_try_issue_directly causes problem=
s */
>> +     is_flush ||=20
>> +#endif
>>     (hctx->dispatch_busy && (q->nr_hw_queues =3D=3D 1 || !is_sync))) {
>> blk_mq_insert_request(rq, 0);
>> blk_mq_run_hw_queue(hctx, true);


--
Chuck Lever


