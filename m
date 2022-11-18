Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26AD62FC20
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Nov 2022 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiKRSCK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Nov 2022 13:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiKRSCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Nov 2022 13:02:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D355419AD;
        Fri, 18 Nov 2022 10:02:05 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIHxIfp019696;
        Fri, 18 Nov 2022 18:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LYHtN4Nzi2+s/a9m6Gwqo8p6ZREQuLqwp06teHSdfII=;
 b=I9Bbfz4X6TNzBqks7Q1YDE1SMm7ceaPaU+OfQ2N14HIBb1/kwsXymAVFfbDVTYFCbz9T
 wbf6k24h3dqzhDwJbvb1vxbY5nKGqY9euZf99x8NZJfb+r6QK0EmKEVH47CGk0Om/vCz
 MA9C996ZBCr36f9sRWMZkEoZSD7UFwW1WTT5Ez34vdVdYc6O+/EIuDoDQIYOrwhhw4I1
 CXEppEa675UHmx85dWzk8XrOJOwiT/a7B/E540A1431oZTzG0tBZluK9Ye6FDQ5FFnKb
 9yYEcDJuihNuqMllZarsr5tzrAuctDv7OJw77nO/ZdXH7XKN+YghTok1XgmhKxPrLfwr Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxbrdgpxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 18:01:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIH1wI8018929;
        Fri, 18 Nov 2022 18:01:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xh81vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 18:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/5QmqCvLPkMxM9Bfmqoe3fmw6Putqx4IbNiR5KcXDBzH9xYerYpH+qqtQMBgNTPaQDB+SScA3GnhKlds7ETvsEOobq+pnjOtXrLt/Ne3aqn5CvpUxy/PRoh3PqZHU/oK2LU5Fq2L+aENUBwRtfT7sExujjd0LGLdDTfwo0GG3IQveh1d//mlXVhB+NtUXOOXFmByA49+Pe/MZNPQ08knlXtlirz8wG2woFF+Ri2gJ8ds+mgwNCRTI18NlR6O8PxQTBb4pv5wtcdlDPQQClS52pQOOFRg42VwSMQCsk2QsyOOTLixRWNaO7LjAP9fVzJ2eSiXo9TzOmB+ZhYVrl/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYHtN4Nzi2+s/a9m6Gwqo8p6ZREQuLqwp06teHSdfII=;
 b=d3TwSQNBu1Jmzv9bBNg74PQe1aCMB0F3cIrBYbSc8kFWbJSGiOePOIq9Z4Np1qH0jFK+Oo0rZddTPsGvPlT6s9xdUkHvJk4w7aTjDsYuQKJBmyxjaT1NZ5HUQcLQ83WcvbO0HFCrBaUqbe65W0hEK2N3FZgXqyShQPnjheJ/cn6aWKPPsElVCUvnGpkYKn7K5bXDWLHwjg1ab9b8U2BNESaipWZVtXUP+bHaAqioa3NjyZBsXvQi+Die+FjokQewINxziRbJXjO8y2GYNoOC14qob2vbZ+cnp5SFC0S0zdNnOK4Jzhgx9oVRgqvon8hNAfoiZvvOcceUpAHZUZa+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYHtN4Nzi2+s/a9m6Gwqo8p6ZREQuLqwp06teHSdfII=;
 b=xXSUkCmboB0QN8LtV8QFwz/3Nb3h2P6pQluvV2Z3IUkReWgM9Hp9ySDzTEYiJ5CoNwb+uA/HLbIDA0RK3HA0iaQueqFMGImCj70CmUd+6SsFXS2NJHdxvVdxe5RL3oH5PDHhrYpgezY/q0R2jwS6LSM3WwIdW5ouPJxki6ZDxDY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 18:01:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 18:01:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        coverity-bot <keescook@chromium.org>
Subject: Re: Coverity: encode_cb_recallany4args(): Error handling issues
Thread-Topic: Coverity: encode_cb_recallany4args(): Error handling issues
Thread-Index: AQHY+29Ez3jSJACRC0y9Pul+LiiJ4K5E+L8A
Date:   Fri, 18 Nov 2022 18:01:41 +0000
Message-ID: <CCDFCD7E-8844-4F13-B160-E9867B3D8AC2@oracle.com>
References: <202211180900.6F94436@keescook>
In-Reply-To: <202211180900.6F94436@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6643:EE_
x-ms-office365-filtering-correlation-id: 1d66c936-0a3c-433e-6b27-08dac98ef226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOckU+AA+ExOhzu5g5GIM5QWhCIioaXHuuS3PFK0icQMWTAnDkO4/IC+X5p13OJjcBPtNyLGW5VpRgu3Be9ZPnKR7AZvA6VjbH+BYCjRc0O8YE7cLPBBLr5cHpk5casev6GJBlGRpvEh+URh3CndPbD/R/fsV9TJOdYD3SzImSEBmxJ/5XHpJbCVme+xOi8J56IAdDvNpYChIrhePkLwNTOYD3TAnWVVoqe32LztZ+PQ4HwTgYzBVLJp7i0koekZXwkr8pJjBoePSBD3wHYfNselZvFOdp2Hs2meSXajMD+1BusKN4Z29XVcd91V4Vk3SHx0CzRJRt32ionKne/wTZwG/QvsRLGgzORK5NsRe3y/humE661sOTQG3/LL+rhAhM/M1xIFXtyKKjsrmYJ4vlbWds+nvTwNNGFGy5qsyzxFRiMJoYkTdHXV/njvt2oqpkBLH/Cx9WwrQb+aBLxJ0yrOB88Na8+PoAA0lpPHawHUtWB5kvLwef2IXI+YDTw3XsI3YYxjVHFJze7jEEVLwLuVBk03ToH48CcegAOyLXoQbpcfTC2dnBewjzoQ26JVef+4weR0VQfnY0mdVE4Zkzwj08BKGNJk1fC+b5FRbY9BP/DtfrM3x8BH5xGMdqAFvfsMtOYmvlhxS6d6bQ5JEsfd3VQlgVBAFGMg2o83Jbheprbr+oQcUf4ZnvKCJaN6+OW9/WOsK26LJUH1mL9tEPQp39ErWo5xPdhI/iUWNaNZ4r9PdMUaiA6v2O+uOJ/z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(86362001)(2906002)(54906003)(2616005)(186003)(316002)(91956017)(37006003)(83380400001)(6506007)(26005)(6512007)(478600001)(53546011)(71200400001)(6486002)(966005)(38100700002)(122000001)(8936002)(38070700005)(6862004)(41300700001)(66556008)(76116006)(66476007)(64756008)(4326008)(8676002)(66946007)(66446008)(6636002)(5660300002)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?asABTlpjaG8qLuKuPRdbizTsiHcHreup1SP/dHrBk3AH6pfe5mzJtjVYZZTu?=
 =?us-ascii?Q?Xxn0ij1OweTW8AZsG0U62XrHpnRP6m95gmX76AVSTbeAPaa3dVR+cSNAneWC?=
 =?us-ascii?Q?LmSmb2GqN4QfhFhIydzY78WEzreXQrS8QxuVp66+xGp7H9EejLQeVLOOo+a9?=
 =?us-ascii?Q?TxMUUmdB4tNM3s59BibnmejVryFaWVT3QDrjmML5/jPlj2pDnmH9stydNY0s?=
 =?us-ascii?Q?dpy57Z6tzrztgpX73fOnnFjNNxsE72+C33T70s25uK9725DQ5A5oadwLfAYO?=
 =?us-ascii?Q?/MakNNw5rzHJiWZHAyzdqyiutU0K/oQF/gd8V3BRZEc7IsyFRytTro18kigo?=
 =?us-ascii?Q?z4nVEE59tkL1raOExNl2DceoAy4GbZsAtiAMkaCM+c6qdk1g2ssrwMchS+8O?=
 =?us-ascii?Q?JXVdTfmKkWKOtxPNSzStW4GQe9d/J7N86EPE6ew21lJVI4j7Git32pLCgJ6k?=
 =?us-ascii?Q?qmbnYKRoiAfJTEBQoGzpawbHhOZRfAPK88vNzrGC5W5Mmi2jC/zX9ckht4V7?=
 =?us-ascii?Q?FzxlkIS1Zs1g6/E7TVQFjAMLdlMj8jyuV/qlR2ZknLSnAn8sGRc/voDS30gr?=
 =?us-ascii?Q?VkLH0SJXRKH8wbIi3BkB573SgMIx/mg7tMsC0s6sisJYvlmQt0H3RxWsxrLV?=
 =?us-ascii?Q?SCyHLRKG+HcqRoLG9+8H7+cYWpuQKLbfHdTiAUOyMr/LnSIeysQ4/Ofdl9iD?=
 =?us-ascii?Q?1tMyCNvWHAuzJVAEbfsQGxpxCQqSB2F+Ib3WQ311DkjMiWQLR6XufdBlI/sg?=
 =?us-ascii?Q?aHqtKFym/ocLuYtYBV1TNF7d2KtLXHyhKZQhA/USSBdNjT9ZjCk06UsFgaUj?=
 =?us-ascii?Q?FLH93b084dPQuY93YX6iP0/teNtWLjjB7ameE3RYOLXQBWDKJf5jRq3IcSBd?=
 =?us-ascii?Q?WhM9/Ahsb3wLyV5AUkRex2NsrdGqPQO6bws2oF2HGyU6eMzZ5M51YunGEGT+?=
 =?us-ascii?Q?FX0v2OWS8roc6hW3Q7aHzQ3szaFXNrbqx+ACeV1pgZq8PXiJS3s6BZa5S0D+?=
 =?us-ascii?Q?yeCIGuVzWwWN7J3cLy+fq3GJOWG5lPWUTHouCtZQ+e0/g6s5B7RV71GTilDb?=
 =?us-ascii?Q?Hj2MBJ9uCeo8ZKtbpKK8i55Z9KUsahXH124D1LjtaDak/ZnEoJnc1WLz7qSt?=
 =?us-ascii?Q?F804cad4g7TGXPJy0+z1BxNe37s/Q2hPeNr1j6OVrTc/tWDp4o3kSbPI1kPT?=
 =?us-ascii?Q?BhIlrLW5IA1ysaOt8jFbMdgtRBGaaxTCV5gyxy2RQSUlqSK/qXJ1BndNShkH?=
 =?us-ascii?Q?QXUP6H0Hwbnwf4B72+VJg+1b2xVM4yLtasJAQiyY3dD6dzzfvKo3uWMNmW/4?=
 =?us-ascii?Q?OP/17odJ7rNZQ6RBfBOMXSW8AC8VRn90F9pI2ND+TzMtILtmb8Os3yPUDH8a?=
 =?us-ascii?Q?TPluziFdt2bHtO8uWwJOIWzPT0+/PFiqXTsMVOJi24H8ILmxL5eh6k8/RP74?=
 =?us-ascii?Q?ynNJTH5mjgXEEkSstocZhViaxkO9rZko5TPDnEypDBsk6PNdG9dO/rIy9dMl?=
 =?us-ascii?Q?6crhXyw2mFkhsZgrkhOnA1ngu52MY6mIJETlJr9mZNrOhOQLaRpsQlBMHoct?=
 =?us-ascii?Q?5YYOYfExqercXUDiVeo5vsOEJrSO63L8IZTHPFlslHKDkNZlky6y/SkNcpY/?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9B8E2D466FE45459849905A83A567E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Dw3tnGi6ufPdRa8E/nu9wy1BK7fEDlM8JDhelAbZq4YlXcZxAx1BooRHjjO2?=
 =?us-ascii?Q?yUe/cTfdmrXcw5lw2R6pcYFnl8oHBF5pByJg0N1UyTN8O1TqqDMU5vCB3aYd?=
 =?us-ascii?Q?SIw0/lg2NWjFBOmeKj+keasVDIRbyrKDoHT1czpnISWwc41dygt7UOnnnvYw?=
 =?us-ascii?Q?JnSodfJXWfMN0zj7y0EzQuMZQ94WQxN1WgI7+kiNzKsttBr9uvvrRZk8VR6/?=
 =?us-ascii?Q?AUkHTkhE/Yb3N3BaJMggvnOWxcLQ/oYdYSwmx83aHlnHG3hLSfain6GLgnmE?=
 =?us-ascii?Q?YLClFvd0kzEgoOv0kbvnv/b5VtMQbWFCazvvwBmROdxtElUbfUvYvyggoFFE?=
 =?us-ascii?Q?gTeMzxAT8TgvJHOG78d4mwz2vNGiBrDYIcbuAtqFY/zHPyV3oKIJKdS5vi2B?=
 =?us-ascii?Q?5A9VN5gQFvKM15f+lZpeTIJdyCXKQFpT4AX+ctD+6K9EsDd/lyLFblGAupPo?=
 =?us-ascii?Q?vA5orNy1YAJzLzFW/amD/K4z5ok/Pp333ZVaI8kAhJGqXYfeFL+6xm7JPqGc?=
 =?us-ascii?Q?/117gDtlzHFyXMEjU26mi6kvb1PZUa/VEt32TRbC7EDzjddzx35ePzrMLa0J?=
 =?us-ascii?Q?Yp1u9DU6ZbdNJRiz5WT/aBVoqdueayywNXhshFrhVN5TmBxR5YysyZ3CZyWa?=
 =?us-ascii?Q?/HWfo+MRjwgQGraAYTIM2toIp8GnDCltJ64VchN3f+bgY7eVpEHedtV/Ya8z?=
 =?us-ascii?Q?GZhiiURLDha7fORmoCdELUAyVdMsvguxWArLdBDmT0M7roCeuhj4isXsx07c?=
 =?us-ascii?Q?vs5vxqjZLin31V4GCA+CU7N5RmlQDOdmPEsHqrOhgOAf/ISRSpMLGkpzhISH?=
 =?us-ascii?Q?UNBTVUA9Wead9loaJIaa3fPXFVVB0zkzjdNBTGvallUjMn54bBNxjKsa0Vfh?=
 =?us-ascii?Q?hVqiqAAYPxazRFIn7gdVLX0OpkoaXcbnVgk6H3FBUHBaqvJmpQXwG/KXBlJY?=
 =?us-ascii?Q?Ipmo4rLPuzyitH9bBKld5gKa5IiKQhXB3mHARfu/qLwfR3Sc9CbAW13+sZ4x?=
 =?us-ascii?Q?mFUi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d66c936-0a3c-433e-6b27-08dac98ef226
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 18:01:41.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Djx+krVG8WZvPJKdqKK2WVVWKdby1jLVRPGyTdxLzwEVMVrgiMFBCI56cnjz3oqzdAJYPP1QW80ZmvfiMPIcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180107
X-Proofpoint-GUID: yT5Ed33wUmyBeCwpofWIaYnLQ8fZwllZ
X-Proofpoint-ORIG-GUID: yT5Ed33wUmyBeCwpofWIaYnLQ8fZwllZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 18, 2022, at 12:00 PM, coverity-bot <keescook@chromium.org> wrote:
>=20
> Hello!
>=20
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221118 as part of the linux-next scan proj=
ect:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>=20
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>=20
>  Thu Nov 17 11:55:28 2022 -0500
>    32dce0f9611b ("NFSD: add support for sending CB_RECALL_ANY")
>=20
> Coverity reported the following:
>=20
> *** CID 1527365:  Error handling issues  (CHECKED_RETURN)
> fs/nfsd/nfs4callback.c:344 in encode_cb_recallany4args()
> 338      */
> 339     static void
> 340     encode_cb_recallany4args(struct xdr_stream *xdr,
> 341     	struct nfs4_cb_compound_hdr *hdr, struct nfsd4_cb_recall_any *ra=
)
> 342     {
> 343     	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> vvv     CID 1527365:  Error handling issues  (CHECKED_RETURN)
> vvv     Calling "xdr_stream_encode_u32" without checking return value (as=
 is done elsewhere 23 out of 24 times).
> 344     	xdr_stream_encode_u32(xdr, ra->ra_keep);
> 345     	xdr_stream_encode_uint32_array(xdr, ra->ra_bmval,
> 346     				       ARRAY_SIZE(ra->ra_bmval));
> 347     	hdr->nops++;
> 348     }
> 349
>=20
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
>=20
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527365 ("Error handling issues")
> Fixes: 32dce0f9611b ("NFSD: add support for sending CB_RECALL_ANY")
>=20
> Thanks for your attention!

My fault. I removed the WARN_ON_ONCE() wrappers, which are clutter
(though they are clutter that is already used elsewhere).

I will update linux-next with a fix.


--
Chuck Lever



