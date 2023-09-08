Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5B7988D6
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Sep 2023 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjIHOd1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Sep 2023 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjIHOd0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Sep 2023 10:33:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F52111
        for <linux-nfs@vger.kernel.org>; Fri,  8 Sep 2023 07:32:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388EVGGv015422;
        Fri, 8 Sep 2023 14:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BjgtjU1tzUihvTVKq813k9DFqAIma4clrx2GGqpGC+0=;
 b=Q1gpuK2VUe1QNIcjwr9hkZqcBWeomP3ivPt/h3nLufr7z1yUffPB4vb8cODOlVbHmqUU
 DDYyghB9nC4IW8FIo1AARJZmduuNawplLby4MSin9whSeX1usFa7Z7QlbRGLtO2Bi1Jb
 ELN4GIFyi8wlBf4TnjowCqTnxBmp4t0NxcRCn6u+29hFIemNpt2xBFihaCFYeqvkUe/w
 Mps9Llm0KHSAQ8uIUKeQUQbkAHp3dL6E3a4rSkpAsBh+BQ+5cdk3vVGeT/MImLz2BnIT
 f6qUoWG+wDAChhRMFjMN+eaC/rpg3czli3bvhv7DPqZC4qazD9BD0NWj4yAnbhfZ5ooR eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t05e8802r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 14:32:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388EOAve030576;
        Fri, 8 Sep 2023 14:32:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy1feak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 14:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI/NdfKf38imr45H/SVtIP8d9m7t91tnmgWxfWaPRcHCeDih9CiaRib782DT20t1B/53eMN/a6eRNvRml8A25P+gdosv16CPPOY2etYh/AIGWoEr436jFWk7Qwt48INdEcqj2vYW8MdL73NQnd7Jap1qEKXdLJOkKup9iqK1x1IdJ5MVqGNg4hht/AK0YBMqCheYL1k2ilouPH6HEx6kqGMKwHFiv+G8QXoFic9brPHaRVJ/nr3Dd+yGLW/YBkr8e6h+YQ5vT2WmE2zIugnS7PtXH4Gd41s0lTPmveUVORt2D2hY9lxVdBZg7X/lZUWd9FENAlUKo0Bi0AwgaanRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjgtjU1tzUihvTVKq813k9DFqAIma4clrx2GGqpGC+0=;
 b=b9uXujVP3REgHzFVLttYa6C8YtSxDWeFWBJIdC5PmeJ/h1snfbEm22I9Lka3F94KCJKfbhHMlh/MzmQ1QfQ7CafzcdUBnwTpM618gbQuFbXA8rTNcpzBh6oFAejV60DLEllwMjdUXH32oZfOjNpY1Heq2kRoS8XyuCZrOwavgU5J2qA+3gZZLiwahROeSFA0JR1H8lqeCQxLmWxI+Xw33J+O61BtariVapl1g55ZhD+kthFwgGVylHnP5nWcJZ5p79vXBBHN0OCMIULjsdShEb7hZu3kYyHd8ZozLGtv81k8fn5s1vPdLu9bhpfb3vg3UXiwrRv8E/tLX9Y5iGEI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjgtjU1tzUihvTVKq813k9DFqAIma4clrx2GGqpGC+0=;
 b=LBVePzB5lzG+6RvA7HjJg5hwsRUdaKvqZPawiQvbU0uK4A3+YQ49zKOm2FrTvG0FcKaK+UZnWdsaW73xHFXwQwe4tOJcqbei/SZ8fcy3C9AXrHqsZMtE4czOJAHU75ouPJIrfddeKDm/+3j+Lb52zTOUoin/4wJrNPcc1fRej58=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7263.namprd10.prod.outlook.com (2603:10b6:208:3f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 14:32:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 14:32:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG_ON() hit in sunrpc
Thread-Topic: BUG_ON() hit in sunrpc
Thread-Index: AQHZ4AjglDLFb5i35EOVcVfzT1/0ErAMU4uAgAMvPICAAFtVgIAADKSAgAAJoACAAQ4CAA==
Date:   Fri, 8 Sep 2023 14:32:10 +0000
Message-ID: <F8EA1A50-7F56-44B8-9D7D-CD30D0CC1FA3@oracle.com>
References: <20230905-netzzugang-kubikmeter-6437d53204a2@brauner>
 <615A8DB3-F931-4EFC-A6EC-CC4DA3766D7A@oracle.com>
 <0B563F93-A30A-4BFD-BBAE-F712F8011E04@oracle.com>
 <169412075594.22057.580928756094478654@noble.neil.brown.name>
 <EA6B6884-C189-4E70-B1C8-1FDE3D982B99@oracle.com>
 <169412553623.22057.2407417994833945901@noble.neil.brown.name>
In-Reply-To: <169412553623.22057.2407417994833945901@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7263:EE_
x-ms-office365-filtering-correlation-id: cd5472ce-a244-43c8-2134-08dbb07862cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxfhzdZLeYEVtBTO5JDf2s0ciKqDGiyESC3XIxJobn49dVxKq+/Z+UuII4Sgkz3d2Im7hIVZNG8zRAQ5SjqHmhJUH+CyhG3BHd/nmuUhIw3fH/tJ6Q4navzqi/ROB+e3tq0+FIqMK1mV0Yk7ElQZOaIGhuwbBHE/HZhi+ALN4hkkXd+nJrEyrBVObkODfLhD260we9nFwIdrrUbinmEQ08yjF7H5sIgu+806U3EasFeuX2zhGqqal4kMWZpc4ymetxj3M7BeNs7tYWxBLVMuoTD11xJSPOI5Gl3NnLG62/51ZZVVVGvmdDdykGHC55FkN4L9QaNKjqHL/Wc6dKfPjepub0BQM/6aedajyWdNDRCFnwR3p9USCVAF38xVOrqfAS3Z1yjgkOptAeubhvgk+HWXDWB4cC3ADHSg2N8A+IGHUGfTkzwNQEeykrXi+olADGcRqp76z+s5Urur4k4gTBnTq7neoMfURntihAOwgIpFHpDIad9ic1B5md8ExI0+yL8d/3rEOYNyPTXRqIyugxnwHxt+74kF6PYy28tY2Xhoi66IuenQlt0ovlTup0JCrDaDOVXKhmRQCMzE9UnvxJjZEhaG3bDAKw3smP8HVotB3fZdG5hreTMmrQhkhakJ2j6y0knTaa2ZNKPu/WgnWmaHtSWoYMX7pV7AmFyT2TujCf6mtsD/jZg6izkbnH0p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199024)(186009)(1800799009)(76116006)(53546011)(38070700005)(66946007)(478600001)(71200400001)(110136005)(66476007)(6506007)(64756008)(66446008)(54906003)(316002)(91956017)(66556008)(86362001)(122000001)(38100700002)(6512007)(83380400001)(6486002)(36756003)(2616005)(26005)(33656002)(2906002)(41300700001)(5660300002)(4326008)(8936002)(8676002)(45980500001)(1758585002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VazMbDoAU4jzsSpnjOShQqNTT5PUnmc+lvh7QzM7fg0fyeKdaIJq7uoQV6Ag?=
 =?us-ascii?Q?rfKyaigxZRLVY8THfBi3/m4y6sC6qM92zTcI+QLh8O320hTtxJaM7UPvyYCk?=
 =?us-ascii?Q?Eh9GDux4bBl8sVUih42zSEhkp4NlHQOgMf2Gfr3Bmdiuo78Y5gdf5e2f/INk?=
 =?us-ascii?Q?/ohjo9BQveOla7oHpDwQI1z+NO8WSf9AC556hNk94wcYcacOpWQQXaGmHWYm?=
 =?us-ascii?Q?w0DnNx5OCbttGrWxIE4EMhdNQrJzEX2pFoD67nsnNExC9dOKip/G3ourR9uQ?=
 =?us-ascii?Q?17GiUGKXBGbadzeBIRrs77HVbBkiJU/5DJfUusDWDxx8mzq7j0iL0LxyBJEv?=
 =?us-ascii?Q?2oSzpi2s17oZC6pAIf2DgSv233C7NwtiY4t6CIeKdZEE4JVRmnxXnMbOkz8Z?=
 =?us-ascii?Q?wunhnoEccmGtRDTM4jbsEKSfm5FxoaZrOjwNOXaS/9bKLf7LvMz3oEoxcF5e?=
 =?us-ascii?Q?7yKRG0T3tcsmwS1kVRIEF7VcwMBmk5OF4hSt6IWVwZGUE/dgW+MmyEklOVZ2?=
 =?us-ascii?Q?kp6wOmxyyBdjamMXzcn1Ek1SaLR69ZjfbWZJ6CsTK9DSU6koFoYY97TQSUqJ?=
 =?us-ascii?Q?iHK5T2+HevQQ7V534CUBV8HuBBvrI4wCelma8rJ3Zjam5GQWc2Aa1DV9+zSy?=
 =?us-ascii?Q?xhvwiGwybA7+d3LE8cvLlwmlDzkhH8A6YZHYr6lxAQi7zBVvGG+9veFyBBR5?=
 =?us-ascii?Q?MrE+nFNo9zDFjXPfO7sQYAN1s/G/2QX34G/e4s665Y6uAUebXw1Tlm8onvJf?=
 =?us-ascii?Q?T0WZbp2rlvUn+KuXETYrB1ts7QWj4gHNnrbSfEuJ6kzcYTvnVzEo87C8e/nZ?=
 =?us-ascii?Q?qtG2uzF6oKLjfIv/+PMqhYI2VUE6Zn/Z25t2OhRdALarlWwAvp2ySG610g7E?=
 =?us-ascii?Q?9JLvCp59DNZukrIy2vPP6FWZvN082tBKnz6+RrmwhhRa3lH8A1TFHt2vimqM?=
 =?us-ascii?Q?M/HrBsDJbwg3RRTFvCDv4IMpnYjv1XUvPH28kr5oB67PfbH8vQ8V2ito0TIo?=
 =?us-ascii?Q?LTYrq6DGPZU08uhm+3nhCSZ8rPeb+L38bszyi4GVPyd6LaYJsHwIpHUZUeLu?=
 =?us-ascii?Q?PQnk3VGTXCCC67kofbHt3iWAcCvalOJ8KHs3V++xkjKAecwu/QTLpkbsHOuJ?=
 =?us-ascii?Q?dCCNsGXXhNbF64dq4M849BRP6ZnEkgrDD3rYehww0p5fzM0holAj1Ed8BLjp?=
 =?us-ascii?Q?/pJlpYy+ey42R6wc1XDcI9ied4HkRLqwBp80fRtSQTrDVcSFEmoNhhmgCjkE?=
 =?us-ascii?Q?BCc0VEq2ZnxL9d1+y13++G8AKJ3UGQBst568r9xAWlW9hDv1F6LjE3th5lUb?=
 =?us-ascii?Q?kzS2lV5cux9ysswKkJP897lZhIFY//LgmcHdDVjjxI3DeG8Hpe6TUFp68f3F?=
 =?us-ascii?Q?gkgrfDGgJzLm/R5xEgvT2OfjpnyOAMObGT8QD2hq7Phc8jcJh1epaSV3CtB6?=
 =?us-ascii?Q?aKp2e1XZOR+KS+gVNeWZI2ZfjCHydOrvZNNPkhhxcAKO28mLchQt2gE8N/j0?=
 =?us-ascii?Q?kge0xUDqXdj1styRHsbF9d3iUsBNZIvMd5B/6VEZ+vRGO7tRRF7bDe71vuY8?=
 =?us-ascii?Q?1s5aq7op5/JeyJj76a0yYzbH1F3aJk2uRN/913w28yaOuFDSHYRefHkz0Y6D?=
 =?us-ascii?Q?gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F55991D596A5174CB8B0534A7B65B34B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1O+SkPXT/Pkw0WeiEz01baBEL7ce22WDCb4Zgv+p38o158ohq8DsCaUl1tCbb/hkgFgT89LXw3yhAkLbWUYQDj0QlVmauG9mYM3DQk3qYIKl/ZmZIhxVRjKgc3Bon3d+ZKfqk+YGjHWV11kuXcufATs/eyoxn4qRTj3M4VdFHvJZ60sLS6GSgoBRtngGOrOnHxl7E1J3ad3XjoJBq7kNN4RlCIL9B6QRnPnYYm2iJ8TZKBZGQY9RWbdVt23jXUyXiVZ4jN7vVvJ9+3NgbYgoVmr9qVvUqlR3GUQSGs/NqsLHj7prJ5RyGCHd30dVQnisZkUmN9npdEQSKKEHdDS6HRb4TN21RfrnMRoKuhmtFLGSQc8eFobwSGfj03GK6xNdMC8Sr8DHjApoaOqkEM5KrWwO4fxLzEC8k2pGQTU/5/v6LLVY9Entr1cyzh1IynPbJ6qTYQYiEL1cEW4JGtzVshpt8c1ccrbWsCyO/paNdkTPU09Jw/HHWN8oglwosEI7TBUo/fz69mEjoq3WZE8Zqkp+zNrQmiCL5Qnx+4yeSDPDpwrQOctzQigLfHfITInYkkOJVr4aBBJUq4t17tRR9ksB9FoOkLt5F7OV5FoRUWJW6wF7+QYdP4W5YQcKk6SVTdiYEUE8+iCXC6wqwBrC73OZlNb11mJe7Ei1BNGqFK+8Pd3rdfjJqpGHO6L/YetyHVNT+gFpzXFT/cQdMVViTKkchB6pkC5vzwiBbuzLFv0QcNuHz9Zt83pfD1e4P7v0DHPtwKADfse2hRJk9Cli3mF9mGsLAd8FGbEbotDJQm2hYn/bIg4HH7aVA7qF4zqP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5472ce-a244-43c8-2134-08dbb07862cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:32:10.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJAd+UBb5PT2pw1tMTMAYYMMLh2HdsFmP9A6AetSLArfhzZ6kH50ZCWU4PCUdZqizhS6YAZq9TnvtQreliQ/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080134
X-Proofpoint-GUID: O1gvDh_LJ25pgRa7YlU8fS3Jt2vpaMoe
X-Proofpoint-ORIG-GUID: O1gvDh_LJ25pgRa7YlU8fS3Jt2vpaMoe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2023, at 6:25 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 08 Sep 2023, Chuck Lever III wrote:
>>=20
>>> On Sep 7, 2023, at 5:05 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, 08 Sep 2023, Chuck Lever III wrote:
>>>>=20
>>>>> On Sep 5, 2023, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>>>=20
>>>>>> On Sep 5, 2023, at 10:54 AM, Christian Brauner <brauner@kernel.org> =
wrote:
>>>>>>=20
>>>>>> Hey,
>>>>>>=20
>>>>>> I just tried to test some changes which had commit
>>>>>> 99d99825fc07 ("Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/=
projects/anna/linux-nfs")
>>>>>> as base and when I booted with the appended config I saw a splat rig=
ht at boot:
>>>>>>=20
>>>>>> [   92.804377][ T5306] kernel BUG at net/sunrpc/svc.c:581!
>>>=20
>>> The most likely cause for this BUG_ON that I can see is if the
>>> svc_set_num_threads() call in nfsd_svc() fails.
>>>=20
>>> Either some listening sockets had previously been created via
>>> write_ports(), or they have just been created in nfsd_startup_net().
>>> ->sv_nrthreads is 0 and this is an attempt to increase that.
>>> However the thread creation fails - presumably ENOMEM.
>>> So we goto out_shutdown, stepping right over the nfsd_shutdown_net()
>>> ca..
>>> Then the svc_put() calls (probably two, as keep_active was probably
>>> set).  result in the kref reaching zero and svc_destroy() being called
>>> even though there are still sockets present (because nfsd_shutdown_net(=
)
>>> was skipped).
>>>=20
>>> I tried
>>> - error =3D svc_set_num_threads(serv, NULL, nrservs);
>>> + error =3D -ENOMEM; //svc_set_num_threads(serv, NULL, nrservs);
>>> if (error)
>>> goto out_shutdown;
>>>=20
>>> and I get exactly the same BUG_ON() as you got.
>>=20
>> Christian, can you provide the arguments your system uses for
>> rpc.nfsd? I'm not sure which distribution you're using, so I
>> can't provide the exact steps. /etc/nfs.conf is one place to
>> look.
>=20
> I'd also be interested in what the changes you were testing were, and
> whether they might cause a memory allocation failure.  If the BUG_ON
> is reproducible, can you check if the is a memory allocation failure,
> and which one?

Christian, another thought here. v6.6-rc now has trace points
in the NFSD administrative interface code, so the kernel can
report what user space is requesting, right or wrong.

So:

a) if you disable the nfsd.service so it doesn't start at
   boot, but then start it by hand after the system is up,
   does that reproduce the crash?

b) if the answer to a) is yes, then enable "nfsd" trace
   points and start up nfsd.service by hand to see if the
   crash-triggering input can be captured and analyzed.
   You can send me the trace.dat file.

I can send a more detailed recipe if needed.


>> Neil, do we really need a BUG_ON for this assertion? I'm
>> considering making it a simple pr_warn(). Interested in
>> opinions.
>=20
> Maybe replace the BUG_ON() will a call to svc_xprt_destroy_all() and
> maybe svc_rpcb_cleanup().

Well, no. The transports are really supposed to be cleaned up
before getting to svc_destroy(), and not having done so really
is a bug. Just not a BUG().

Reporting the problem /non-destructively/ and leaking the
transport resources seems safest. Heroic recovery action here
makes it look like it's expected for there to be transport
resources left at this point.

Or, we can just re-arrange the whole shutdown path so that
transport shutdown is handled only in svc_destroy().


>> Past that, obviously input checking is missing here, so the
>> error flows in nfsd_svc() need improvement.
> Like:
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 5e455ced0711..f2c4e62e4591 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -819,12 +819,12 @@ nfsd_svc(int nrservs, struct net *net, const struct=
 cred *cred)
> if (error)
> goto out_shutdown;
> error =3D serv->sv_nrthreads;
> - if (error =3D=3D 0)
> - nfsd_last_thread(net);
> out_shutdown:
> if (error < 0 && !nfsd_up_before)
> nfsd_shutdown_net(net);
> out_put:
> + if (serv->sv_nrthreads =3D=3D 0)
> + nfsd_last_thread(net);
> /* Threads now hold service active */
> if (xchg(&nn->keep_active, 0))
> svc_put(serv);
> ??

Possibly. I'd like to see what is triggering the crash, though.


> NeilBrown
>=20
>=20
>>=20
>>=20
>>> NeilBrown
>>>=20
>>>=20
>>>>>> [   92.811194][ T5306] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>>>>>> [   92.821472][ T5306] CPU: 6 PID: 5306 Comm: rpc.nfsd Tainted: G
>>>>>> [   92.828578][ T5306] Hardware name: QEMU Standard PC (Q35 + ICH9, =
2009)/LXD, BIOS unknown 2/2/2022
>>>>>> [   92.836319][ T5306] RIP: 0010:svc_destroy+0x206/0x270
>>>>>> [   92.852006][ T5306] Code: 72 49 8b bc 24 a0 00 00 00 e8 a6 a3 5e =
f8 48 8b 3c 24 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8f a3 5e f8 e8 =
aa df 1c f8 <0f> 0b e8 a3 df 1c f8 0f 0b 4c 89 ff e8 39 03 79 f8 e9 ae fe f=
f ff
>>>>>> [   92.867075][ T5306] RSP: 0018:ffffc9000a347b60 EFLAGS: 00010293
>>>>>> [   92.872714][ T5306] RAX: 0000000000000000 RBX: ffff88813abf5c68 R=
CX: 0000000000000000
>>>>>> [   92.884809][ T5306] RDX: ffff888126c38000 RSI: ffffffff896bcf46 R=
DI: 0000000000000005
>>>>>> [   92.894190][ T5306] RBP: 00000000fffffff4 R08: 0000000000000005 R=
09: 0000000000000000
>>>>>> [   92.900512][ T5306] R10: 0000000000000000 R11: 0000000000000000 R=
12: ffff88813abf5c50
>>>>>> [   92.907935][ T5306] R13: ffff88813abf5c50 R14: ffff88813abf5c00 R=
15: ffff8881183c8000
>>>>>> [   92.917264][ T5306] FS:  00007fabf0bba740(0000) GS:ffff8883a91000=
00(0000) knlGS:0000000000000000
>>>>>> [   92.924880][ T5306] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
>>>>>> [   92.930358][ T5306] CR2: 00005568a27d60e8 CR3: 00000001737c3000 C=
R4: 0000000000750ee0
>>>>>> [   92.937465][ T5306] DR0: 0000000000000000 DR1: 0000000000000000 D=
R2: 0000000000000000
>>>>>> [   92.943057][ T5306] DR3: 0000000000000000 DR6: 00000000fffe0ff0 D=
R7: 0000000000000400
>>>>>> [   92.948673][ T5306] PKRU: 55555554
>>>>>> [   92.953452][ T5306] Call Trace:
>>>>>> [   92.958082][ T5306]  <TASK>
>>>>>> [   92.962546][ T5306]  ? show_regs+0x94/0xa0
>>>>>> [   92.967221][ T5306]  ? die+0x3b/0xb0
>>>>>> [   92.971702][ T5306]  ? do_trap+0x231/0x410
>>>>>> [   92.976275][ T5306]  ? svc_destroy+0x206/0x270
>>>>>> [   92.980717][ T5306]  ? do_error_trap+0xf9/0x230
>>>>>> [   92.985287][ T5306]  ? svc_destroy+0x206/0x270
>>>>>> [   92.989693][ T5306]  ? handle_invalid_op+0x34/0x40
>>>>>> [   92.994044][ T5306]  ? svc_destroy+0x206/0x270
>>>>>> [   92.998317][ T5306]  ? exc_invalid_op+0x2d/0x40
>>>>>> [   93.002503][ T5306]  ? asm_exc_invalid_op+0x1a/0x20
>>>>>> [   93.006701][ T5306]  ? svc_destroy+0x206/0x270
>>>>>> [   93.010766][ T5306]  ? svc_destroy+0x206/0x270
>>>>>> [   93.014727][ T5306]  nfsd_svc+0x6d4/0xac0
>>>>>> [   93.018510][ T5306]  write_threads+0x296/0x4e0
>>>>>> [   93.022298][ T5306]  ? write_filehandle+0x760/0x760
>>>>>> [   93.026072][ T5306]  ? simple_transaction_get+0xf8/0x140
>>>>>> [   93.029819][ T5306]  ? preempt_count_sub+0x150/0x150
>>>>>> [   93.033456][ T5306]  ? do_raw_spin_lock+0x133/0x2c0
>>>>>> [   93.037013][ T5306]  ? _copy_from_user+0x5d/0xf0
>>>>>> [   93.040385][ T5306]  ? write_filehandle+0x760/0x760
>>>>>> [   93.043610][ T5306]  nfsctl_transaction_write+0x100/0x180
>>>>>> [   93.046900][ T5306]  vfs_write+0x2a9/0xe40
>>>>>> [   93.049930][ T5306]  ? export_features_open+0x60/0x60
>>>>>> [   93.053124][ T5306]  ? kernel_write+0x6c0/0x6c0
>>>>>> [   93.056116][ T5306]  ? do_sys_openat2+0xb6/0x1e0
>>>>>> [   93.059167][ T5306]  ? build_open_flags+0x690/0x690
>>>>>> [   93.062197][ T5306]  ? __fget_light+0x201/0x270
>>>>>> [   93.065020][ T5306]  ksys_write+0x134/0x260
>>>>>> [   93.067775][ T5306]  ? __ia32_sys_read+0xb0/0xb0
>>>>>> [   93.070501][ T5306]  ? rcu_is_watching+0x12/0xb0
>>>>>> [   93.073073][ T5306]  ? trace_irq_enable.constprop.0+0xd0/0x100
>>>>>> [   93.075937][ T5306]  do_syscall_64+0x38/0xb0
>>>>>> [   93.078394][ T5306]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>=20
>>>>>> I haven't spent time debugging this further. Maybe you see the issue=
 right
>>>>>> away.
>>>>>=20
>>>>> I don't, unfortunately. A bisect would be appropriate.
>>>>>=20
>>>>> I will pull today's master branch and see if I can reproduce.
>>>>=20
>>>> I wasn't able to reproduce this with yesterday's master. I don't
>>>> recall anything in Anna's NFS client PR that might account for
>>>> this crash.
>>>>=20
>>>> Neil, I think you were the last person to touch the code in and
>>>> around svc_destroy(). Can you have a look at this?
>>>>=20
>>>>=20
>>>>>> This problem is only happening after the nfs merges afaict. I'm
>>>>>> currently using commit 3ef96fcfd50b ("Merge tag 'ext4_for_linus-6.6-=
rc1'
>>>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4") as bas=
e
>>>>>> and that splat doesn't appear.
>>>>>>=20
>>>>>> Hopefully this is not a red herring.
>>>>>> Christian
>>>>>> <.config.txt>
>>>>>=20
>>>>> --
>>>>> Chuck Lever
>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever


--
Chuck Lever


