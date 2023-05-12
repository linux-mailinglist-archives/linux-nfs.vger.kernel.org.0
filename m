Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15D700DE3
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjELRb4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjELRby (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 13:31:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87104195;
        Fri, 12 May 2023 10:31:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ltM023081;
        Fri, 12 May 2023 17:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xh7tf6v2EEhfYHb82rBEhnh+Jjx+B8NV4Uu3LGy9TWY=;
 b=Zm1LJJHIfkvyPAdblzeZmW5oe1+R4/+sUPBMEQFJoKBtdLshkGmfe4sNo/FPyWHokpuN
 lVu9iGqukLlUasJ0jMqHL8vIVuUkgLuQwGXFAAsvXlp68Jo6X//o1Uf/UmxWRqgPcdkx
 7lz2pQ+7SkgOZMIoSrTwIShgmbcd9hawA99w5nyyXg2O+PbuF1I935s1xi/I7x/X7YV0
 KIK7UlQrcWnV6HyzYvb/hong7sml1KFOhGWZHzRJ/wv5aJ3h7K+YDBAsljkqUlgOG2cy
 ugagy4bOE1UjAxQxAiRdwHxYPgrg2Iyvx3x/z1ZEoacVOy96Xc/807b1R83J5+Nz/M1V xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77gbg4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:31:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGGWAj030547;
        Fri, 12 May 2023 17:31:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81jvrfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXdQizMvjtODfARcDkfKVR5c+sh4U3Hq41/0mGjyKA8sI4sE28CdhFGUmYZtfHC+NbfE7zA6ICEBfsAVdTkJswMvozb+xQ3qgESJNo4m3eQj4A0V61MJ4mAlPfCNkC+5EaXrxe05i4QwkvENnbFkbx77xaQPc3AvcF+5xozJXgzOrrG+HLfO2AX6nFaQbALQ7TVtNbBOsm2mryc16vp4lclBpvkZnHQsLhw2mEyxunlxD4JwDyV3zPoOBotpeFOA8MrDsRFVis/wRh/ZXcUE/7MJs1A5y0Yb6rwLyfFEwzEQP4+O0j0neltjJcNSJbWcSlFWmpaDCnjjul5CCck+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh7tf6v2EEhfYHb82rBEhnh+Jjx+B8NV4Uu3LGy9TWY=;
 b=GYAx6t3CQPVAtVU+3t3AydI/kk37uB+jqQDJH8y9ItFen6W1qNysIbhu3uvlYauJWbnRRxR2k2O1Iao4vBfGSvZWHm16XPQsFWdMk+J60gy7suvrpn6lWM6REgdQWg4OxUgBGRgCmISCj8r0w1KDcRd6b9rErZbbZbn1IbGsTgva5kxIP3EihybDB54ArmepYuKnqa5/S8i/FnUoGssb7LtAXTwpkUXw4WWADIzPeVFVCA6NePjWMdlapaoo/3IroaWgSOxZlRPxIQRufpJpwRQQqN9YMMXXxAp6aTfhYaA5d/9iVm9gN5WY4QUCyTx6uQBYdkp17RzCqCBT4yDXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh7tf6v2EEhfYHb82rBEhnh+Jjx+B8NV4Uu3LGy9TWY=;
 b=mc8RKz2AN7rxYF+9m/g1BDIo/0Q4Lx+ud0SlDrbe1l4vGQWQpoqAtPFkWvb4vilfq/uhoODkG7DaZBZ/8BJ7a/1T8tLuaRtNIHcV/Q0rPf4AcFcUcGoOXgF6NJ75KG4w1RN+Wxg3pkM8hdpoiuStDGmu6/Z2UENly25SClfcmgI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4480.namprd10.prod.outlook.com (2603:10b6:a03:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 17:31:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 17:31:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Topic: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Index: AQHZhOJYGV62rs3GkUCJMHqFG7AZcq9WvaEAgAAnyoA=
Date:   Fri, 12 May 2023 17:31:43 +0000
Message-ID: <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
 <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com>
In-Reply-To: <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4480:EE_
x-ms-office365-filtering-correlation-id: ec7d202a-b0a4-43ba-6e40-08db530ec147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6p1JlMc0n4RWaG5PO4QsmN6IBQ2p0IE8sCwWUBCuJgcP1z9qd4f/y5qCAw84ah4Slt68vJ32ubpzHvU3UgaHgAfaBMcKAj0RfXO2KPxUtiB5w3bZqfaaKy6cORQBnJGnGdZ6wRlqzMg0PV1C2EwqVjsSupeUsC0SdCTZeftW9zfq/h9Zzau83v4rLxvoSOC9jU6bA1iCj8ekRnKX3Q8/4L8xBRo5mTl8IV+7pR4dmUyAWw0d6BRm7D8tUdkaQMe1L+DLpw4YdrW1/aDPhk3GBkhPmxx8mICkt/lbOQXWumDmMQn104IpQfkOmETs7/z4LZ74E9PISg7loUfKB31sqlQwt4TyomAIUKYk8EB6Kf9A1y3QANmHZDVIIuwpKgPR/ovA7laSskphESbr5ut8negDYjyDOEkDu8H4ajgH8T/lnr7N0xOzLcdTdMXRoob7lntLCEo5csdS6kGv7TBCIdRZB7yjrDjebj6+ctrv4dF+ISDC+t87ewdanYLmrne8D3qmjZtiCgP4GdaYUul6w3YH1nheSFZ4iTHxIxeM0lsOV7IpVKv73yoJApn1s1NhtAXsjjVfNCT/dyOhcPSW9LiYphkZLP8UsLFHpVW33gbrEOJ4iqMER2Hz5m+ktIOp6Tis7e2JiQAuOL0aw4i+tjBhsgQ7CeoFhxp9be1MozWRyyNHS+3l0/bEeikI84BewB2tjR0gP1yOWLSIY0d8gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(6486002)(54906003)(41300700001)(316002)(38070700005)(71200400001)(36756003)(478600001)(91956017)(86362001)(66476007)(66446008)(66946007)(6916009)(66556008)(76116006)(4326008)(26005)(6512007)(83380400001)(122000001)(2616005)(186003)(38100700002)(64756008)(5660300002)(966005)(53546011)(8676002)(8936002)(6506007)(2906002)(33656002)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VbIP3YMV7lX4STIJiP4nisXV2kaE3M6wsVYDZg0aqW06c41r1QyHmzg5/DaG?=
 =?us-ascii?Q?+rRY898dQ9iOQfYjShNxRxhjxKFL8eHAggtvuzwhF4SzEtAYHi35nmKB1sR0?=
 =?us-ascii?Q?YIqqbMcrwZb1agle/9rVoXRctWWb4SUvY47kvBLSnKW19yAQq4ygoKwzmNNa?=
 =?us-ascii?Q?8TWCf0GhhQ+gLgNz5R+JAhti6favF8DlL4E3agfBMvPaBFMDW8aGUaholIly?=
 =?us-ascii?Q?eZD5sbV1lL3DWBWsZX8VHe8Jpg/oEcoqpCZpVUFjgzv/PdUoEc3bdteRsKBf?=
 =?us-ascii?Q?N6eme7u6Vj5vctYLDfDHjJCq9lyj3S3IA79/MCli9PFf7nzHT0b5Qye1Fypi?=
 =?us-ascii?Q?phBmVaqLpMFICprsJkWegmTi0zFj+J2bQOF1bFdj1yEvZr2l5lEmD+LTu/Pz?=
 =?us-ascii?Q?7GOaThyriPF+4Y0hdujzaW4rE/hXCtND5F4OtMzsIwrgPY/Ufw/i7aTWd0EZ?=
 =?us-ascii?Q?CTdG6mfVG08i8Xgg4ciPhepwPzO1TTsSy9nRxUvwS0gVARxGZbiTWX4oB3LO?=
 =?us-ascii?Q?BthIPczhfGHwT2Pa6+eJ9+Vn9bOexObWoHWvKqVsTuL4mstj2yW0gx5sQOpO?=
 =?us-ascii?Q?tvVZP2Ra3bXoo+mYPFnFvZ1cf8I5ibWcxjnEX0xn4k8J1/OjmbzIs83Hn4JA?=
 =?us-ascii?Q?JKw96SvUTQMTsv37H8nLsilO0HQrEJGWaezO7hJH70VIoFlR70fkx1E6u6lM?=
 =?us-ascii?Q?hvV0J8H9BAFm1XS26NR+/Lphr4xJ2X8UFumQKUaX4flTYEXCyxa0D7IQ95ZR?=
 =?us-ascii?Q?BEA0e5cD15INU7TYDN8BW23MW2YgzW72SXazvrRkvm/B9k+SNnV/FULkgBEk?=
 =?us-ascii?Q?fzWHdgL+gYU+1L7Z2MVLOV8loMsN8WDVwZiTDBF3+R5WvPi7sO+7DYQdu55T?=
 =?us-ascii?Q?jAolI0XfaJkwv2VCvwjflD3QIbPwbPZPszjnmbnzU2YZVo9SfzgV11aq386g?=
 =?us-ascii?Q?6hz5qK4jlG33e2czbcDdOeIENQsfAsaIjAOiWF4iQjw6gCqVrzT/uLLvJa7W?=
 =?us-ascii?Q?r9UeAwVQ0BtcvbPUsGucJ0mrK/DD6XJ8gqwa/sfQ5bf4GhBW4tfcXezO543E?=
 =?us-ascii?Q?TxFBqBRe4PySBI7GbSp0uB5NQssjThT5BF09qXOrX21B/cX6WMmmYAbvW/Fj?=
 =?us-ascii?Q?RVa2UfzKkR93YkjTwn7P9xhsx4PH3O74MM/8CWTkxATOPHCfGaUXFiwZcRpP?=
 =?us-ascii?Q?QALZkyt0QbmOnZ0cS4+iB7QmOD/XeT+5Q7SJIAQ30uNTZHarF6VwAvCknJbX?=
 =?us-ascii?Q?4fa4rm2AQcI4rHCSFu6pkgm1EezBmJUQJR0WAGL3ACOjzpcPrbENRt1hkw/0?=
 =?us-ascii?Q?QC5Sre5kC0zsNTF84eT+Fq/Igc/vssK5K6S6BAaAU72ciQju8AsaN887Y+VQ?=
 =?us-ascii?Q?/F2dQSQPL1IpVw96+ElEo18GIJ37DE1mvhnmW7024josQi22fT8zFPAzuzpC?=
 =?us-ascii?Q?GCCdB58VHshEvdTn7o1bwWKrVp0ajfO9KY/sEFSzdeT64vZFADUl++zU3CtM?=
 =?us-ascii?Q?0KxnHYTc1jULhRhw9MsyK0NXLApe8DKaOpuO+3YKSSQ2TVrcvRltv8vf+jsX?=
 =?us-ascii?Q?fNOvm6soVVmw5PB+tEEMTBwMnvKM5Kdyr1xhY2YEFOXVXFVM7f0BJO/LO3JF?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00A2822B9AAEC1458262B14762722060@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s1JQhZVCihGssfXMrZ+jq+xcCNP48EUBvjl+mH+Z7MvgS/aVbkQvIDxbRDj0mKyBttAZ0TObQXKDIn+F9iNRsDYJx7rj6AL9CZg+mXnRkFsRUNEpoNK/ZVMB6xqZwVrKSikeORqLLUOHhKPtz38isy6272J7Uomdx16iBqKjQu4e5qu7hR95N+rjr1KuYCC3/ovZirIRwTBHCioofS7XV2J/tUYWZOXlz3xCtBR1KftNvovtio84023RRkeMYlxPXbtmIiN0LJV9adnahxlxjExiSqq7i6bQ2m0Zsryr9H6mnN/avKQvlqRDKb6vIH/b8jdi0JEIiUTMY8Ozmz8rzsn8TNTkSTFmp/SPX5/DeZ5Ntig2OQQYMIimjQiAu+Ck62T0P0zN3yaDcjfR6BALQd/lYPBelQb8gsIQ9I0+Onq7t0P+e77mqxCycBA/HIfhIyrV/7ucOfC4o2zVuuv4GqCXJ8HL/y3JwDA1wvImCqFdtcrWi56so9mw0oJKKofbzgK05/9d88oZf53V7N0okn4PAsG9aicSNEzPWuWaq4UTkWFk+oleM6ZPjHdO1HXn91lTbPMlu088ClLilI+AJMNWTUtvOQTVT6PHPi0uIc23eciNeykNA3tMJQ4/H91dciOsf6Div53Dafvd8CZfmqWK/gQWUtx3j+oK85Ee9NoAuQAINcxMpnI1mmezBzrTpA2xBAl0rmiEBWg+OPpVbHUKw99f8lhsLqgATX6PA+BmvQtSICs7AQGdCWfjC+9WaF6EZ3N0bQIDOhGkwltS1pBKtYRacNZ5/jPPISPdfK3zij+h2VFr1/sz0JyQ1bXXbyyJrfGwvd1LDh8A7NCojC1STY1bsGqVmoJK4wS7UYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7d202a-b0a4-43ba-6e40-08db530ec147
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 17:31:43.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vR/28KCJwcyWn9h1iX4bN+CvzhMVzPh2uKR9QNHvSy26WXUbBbZhlGwKCKC/eWE1ckdewUyswQ5pa+6AZVZkvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120146
X-Proofpoint-GUID: iIawCqJUnSY8tESA1oZKrKa0jU9aI-RZ
X-Proofpoint-ORIG-GUID: iIawCqJUnSY8tESA1oZKrKa0jU9aI-RZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 12, 2023, at 8:09 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On May 12, 2023, at 7:53 AM, Azeem Shaikh <azeemshaikh38@gmail.com> wrot=
e:
>>=20
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy here.
>=20
> Let's update the patch description. This change is really
> a clean up -- it doesn't address the memory issues you
> originally described.

Unless, of course, you intend to apply this patch /after/
a patch that fixes __assign_str(). In that case, no change
to the patch description is needed.

Acked-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle.co=
m>>


>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlc=
py
>> [2] https://github.com/KSPP/linux/issues/89
>>=20
>> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>> ---
>> v1: https://lore.kernel.org/all/20230510220952.3507366-1-azeemshaikh38@g=
mail.com/
>>=20
>> Changes in v2:
>> - Use __assign_str instead of strscpy.
>> - Added the Fixes tag.
>>=20
>> fs/nfsd/trace.h |    6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 4183819ea082..72a906a053dc 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
>> __field(u32, cl_id)
>> __field(unsigned long, authflavor)
>> __sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
>> - __array(unsigned char, netid, 8)
>> + __string(netid, netid)
>> ),
>> TP_fast_assign(
>> __entry->cl_boot =3D clp->cl_clientid.cl_boot;
>> __entry->cl_id =3D clp->cl_clientid.cl_id;
>> - strlcpy(__entry->netid, netid, sizeof(__entry->netid));
>> + __assign_str(netid, netid);
>> __entry->authflavor =3D authflavor;
>> __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>> clp->cl_cb_conn.cb_addrlen)
>> ),
>> TP_printk("addr=3D%pISpc client %08x:%08x proto=3D%s flavor=3D%s",
>> __get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
>> - __entry->netid, show_nfsd_authflavor(__entry->authflavor))
>> + __get_str(netid), show_nfsd_authflavor(__entry->authflavor))
>> );
>>=20
>> TRACE_EVENT(nfsd_cb_setup_err,
>> --=20
>> 2.40.1.606.ga4b1b128d6-goog
>>=20
>>=20
>=20
> --
> Chuck Lever


--
Chuck Lever


