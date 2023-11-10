Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671587E8285
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjKJTX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 14:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjKJTXK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 14:23:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886111997
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 11:19:49 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHiErb030916;
        Fri, 10 Nov 2023 19:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=afyXNEx6vlvrvm///yVFgX8X4KJxcaMvgPObVqX8J8k=;
 b=qafLSMjDVnW8JZDrwGqVmu+iv3fuxdxglfippJ3FlATtl+5Ju9Ru5BmLqse0CeSIhTlk
 YieGwkuOm6J9VvhkuRdgUnZOGxSofosIE8KTLKZ3EfEPb4M4jXlZdu8/gZSZNTm52LoN
 cO36fqihTWVzXnk+brdXbUylVMMwvQn21zQbM+ERuC7Gf7j40iLKGLcuzsAr3w/hbFZQ
 zAmYNTwfeMoqXwmakekt2HKOdHwxk9YilAjWlXQVC8hEj8ojhVx/bWKnAMPoxr5e6Ow6
 w5NDQSXYix6TU+DAKDukAQZRTaYD0yoXnQoMyCEmmviabZwDsfJGiXxZs0TSw2GdLtrS dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22pr51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:19:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHIZP3024820;
        Fri, 10 Nov 2023 19:19:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u9fr77d2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9J899y7F0eqfpfu5JoGRoCC7wus094ZGHRpTa/h58SDja+PYdhJrVJTCCe9gqLoj/Kxf1rsqYqU9YXe0dJ6bBG05M8wPaYPIdSpiwnkHrAWDGYuURQgOqUQMq6WOTM53DzRusekgTE6+hvHv89ZxebjgX2szvvF9w/sHcXwmro7MoMRFykiYD/9HZzQX0A/7Ab8OXx0koIySzClVHGRFVh6KUznU7kHa549qlbgIs+FcOtYq4qdIGOZMtE37OhgG1ptQo03H+kVX+0OkeQ2BvhdAf6KUB6ujqhuYDjwGU0SQF/OHXtyGxHlcLrkwPZJbym9ERLuPeda3D/zIreqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afyXNEx6vlvrvm///yVFgX8X4KJxcaMvgPObVqX8J8k=;
 b=Y5z3DJA2Hf6if0BKNXhn25KSBdkd5VdFppT0VUTQHZjyKwgIgJyPMx1CzGa+9iFSRmoBt5PUyToLge7OTJ+D6yA4CnL+5KthDwIMFKbR62gRcX7idP3ig4C2T02iMa4rFwn2bpj7CyGIdjqW+Zec9APJ4tovFGkifZ63qUhZWhfkDqTs3fxugBuJvS3bM2XZVK2y/PRBOSlKaLpjVdAl0Xal2pRgZhiBUujGrZqNoxc1pUIGlEFr6Ra1LUOG9qPeWTsRooyiqSnYMjpn+f3BohTIHmxXCEZuKx7O58bYSxmTuVpSRQoE9KfF0XGN4c1JBNv6qIKXW14cfiTBuJnJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afyXNEx6vlvrvm///yVFgX8X4KJxcaMvgPObVqX8J8k=;
 b=D+CSUcoVNcj0/o8hqvspJbbRoFe8B7nUjfi+2Y8x6lqHcPKEGHf4xxmoyCiPdtFct41WUzfxcZnz8UvRfwAm1XvBYERwCWlgrgsrtGXykpClCGKbzAL6HaXuU3Payz+GPVJ3enmvMzJnou+4mXTuF2K1Mk5jYfR3i9CPWL1anZ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 19:19:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 19:19:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Martin Wege <martin.l.wege@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG: nfsref(8) has no means to set a non-2049 port number for
 referrals
Thread-Topic: BUG: nfsref(8) has no means to set a non-2049 port number for
 referrals
Thread-Index: AQHaFAJ5D+uFQhzGYUyPPisPzgWJorBz7amA
Date:   Fri, 10 Nov 2023 19:19:45 +0000
Message-ID: <35036897-BCB2-4445-BBD2-64537E34236B@oracle.com>
References: <CANH4o6PDTLSVbMOm=oRLhuupRSkQ9bZ8NGBAmgAa5i6PNCm6Ag@mail.gmail.com>
In-Reply-To: <CANH4o6PDTLSVbMOm=oRLhuupRSkQ9bZ8NGBAmgAa5i6PNCm6Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5817:EE_
x-ms-office365-filtering-correlation-id: 6fb0471d-1147-478b-4d87-08dbe221ffa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZOLi9W9wQMmLrf2u5TKRClBzNe47rejajB3xiwbah8a1P8pNnpfHpviKoLcHxMgqL4s5Uc7aliZoBRZ5xY3R8cUMDZzPlmge7JdykO8u34WMeWZc+TExxm6cNxswvDrU7WRx4CI5zbbdy4eS0+kTezYqh+JV+gpTCI4wUlRiHAW8bBwHuDCbod9W+7MkkZHckVjwLLIvjwXty/g8Zk7OFcUupPGesDK5c9V1XVZ1az7WYEBkUKSSSNluL6iRFDqNVlnFyha3/7IvscrnJFKtgFf4E+hMLS9H8zIM7kpGbcYMCGNZZKmjcOGxTKcbMsxRKM8lWlgZmdzk6uSaRflWyePfBXD2/O2Hvou2WYY3yNPwZCzGHDfCTKRWdhvjO1ZFj2sO388gYqKf9Mrb4V7kJgWh+bhQDKcGYfl09X1/n1RvKd7qCBuod9txIypBBHMBDvJhq/oRvw+QoJ3/u6uZ3Dsii5yJZsqKW53BHb2uhVuNp89k+ixUw2cOXG6ZiPykBxGWdlu0ib+t+u7acbF9z285tm9+UUGPdJGcRwYW6yFmapcPrCWyO3uOrQq4DMjDIJbn0jhRYY/MFRmNoT8lsAgwUf95tICrgilEfLHHtfNsxIlF0+kuF4c8azRjb+SriMcOV7PpKlXZfs6SKjzQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66446008)(478600001)(83380400001)(71200400001)(6512007)(2616005)(53546011)(6506007)(122000001)(26005)(6486002)(38100700002)(64756008)(91956017)(6916009)(66946007)(76116006)(316002)(4326008)(86362001)(2906002)(5660300002)(66476007)(8936002)(41300700001)(8676002)(66556008)(33656002)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ifbM7etZY8wgtbRGwWi1ySi0yrqnZl0/qK6K8ckKXbYPZAerFfhIj3eV7FC?=
 =?us-ascii?Q?AvgTrJNwOD3pBpnhzRKpQ3UfKwyyvonXw5fw2LwX4FfX8iEYZPJUqiq3fkce?=
 =?us-ascii?Q?72C5vS21rj2b8ynV13P6ik/MibYVtzOhljLWZIUSDlNThk6Z80meRIyO44Jc?=
 =?us-ascii?Q?7E18dCWb1U1eeuPdLJZKEfUMIMGW6DLn3XiiHa+WtnQqrUxpewmxDAKd9tu/?=
 =?us-ascii?Q?BZceM16mkSSeNMrgoxHAXHu/OsUG8XNeRbOQGgvihJCtqx9jGEibAbhvdR6n?=
 =?us-ascii?Q?VlAAXNU7hTvI/9+rIJuxW8sOgBokAh0AfSjC89OjPdec2g9fvtpdqhqZq0bA?=
 =?us-ascii?Q?ND8HfaAxnc6Pk/ZGG4S+ROJeQsAPb6UOF1qWgZArFxCxCjMRvztV22Up9aCl?=
 =?us-ascii?Q?VDHbUTQe2NSWZW6hUXJCDEE6Di4Kw1RYk7rGiARqx2diMcdCTUDhJVzNLSXo?=
 =?us-ascii?Q?yJuaXeOrN0Gi+tpo+O6T3ur26L1db3V6HaScif0qgWjlEwZWcLK0aUWt7cOE?=
 =?us-ascii?Q?TPaBD7q7aBVxZFYpNyc/A9FcjAaOpY/s19kjnc9OmWQRzV82eyuJElsAsRAo?=
 =?us-ascii?Q?jDy0YbMlL7Mr9OC8vU5iwDYOkLY/KZgKRbCdd2N9c4rkYqbEjPFxvwBCr/J4?=
 =?us-ascii?Q?sZ2SSoBhvkXjHMsfYw30PJPn+FRpUUfscHrqgbCHo5od1E1d4Cfnm2jUeviI?=
 =?us-ascii?Q?dv5H8I/qjRE2Hsd+WOhJ0esw+HM2zOM5o22PYqzAfcfAYPdmxO8FrqmaZ5xw?=
 =?us-ascii?Q?WcdYyuSe4mJ0SejFeeEpdbNwxxfXUbzZWLtT8LGfJyYLcMEQfJAtMJC12zN1?=
 =?us-ascii?Q?5JD+2ckGHqMBjdQ+8mp234kj/7pqauYpW9VDOhv7snwqCoEauKJ+wMUL8/uj?=
 =?us-ascii?Q?YtH+PpxyG1UwyRdKeR1RSg8rKoXSnYaTMpI3OrktlEfyrxON+XTAq42EeZxB?=
 =?us-ascii?Q?OpCojpx0vZdHa5S3TCZN4vOxSqMZDvtORKnAIjaJOmC8McZ0X0Oj+KlbW0bW?=
 =?us-ascii?Q?eFFZODJiuKsEcRpgQlYwQSmHpx2p9qsHskfw7K55iZtarK0A5H30nZXhJTbi?=
 =?us-ascii?Q?sqCfn41H69R/Alu8fXiP6WZa7/llKOiPy5UjotzgSUgKdXjhU5uJUWdYhx+w?=
 =?us-ascii?Q?JKLw9VBJCP//QyskzgnsXLlf8ZtSG8bv9oIfZ4nhXUOr3wJ5RL/cUouFd62d?=
 =?us-ascii?Q?o1WRhjJIuvesQyW2nQsMU/NIaE88i88b5Rm9iwSe9exevMIl6xgdtyt1WdLM?=
 =?us-ascii?Q?lhS+jRrEM0q8gpWgN7BtIVW170fJTDFfakDVJn2sDV/VKVyPtEKZ3CsgLzyu?=
 =?us-ascii?Q?ckE5ZNWWRc9v810gCXohRMKc1eVRddg3wteOnl+8dGhpYa9KNuWwgtYo0abt?=
 =?us-ascii?Q?fZiLZPXvv8Rn0ekykZG7iG/FFX0I8S94k+OGubTGW/cnv8hx7lt/QWI5mYP4?=
 =?us-ascii?Q?Ce7nDQz0GXIeKLWlqIC7AaKYX01VNwN8k9zQ3cWd3JHf2Vse1z/jSTlPo4n2?=
 =?us-ascii?Q?cLNa+JqBgjBJ6o2ynI5ueqAa2+peVV1Cf1rD4AIlfsLDSkBg+i8Sc4DFueQP?=
 =?us-ascii?Q?KjhMYySikTZFVuYY12WvBN6u4PLK4gFUI+QStdlEualdBBZM1UvNhhwbYfo3?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3219F7185CD5C44956739BDF2616ECF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BSzd28VQH9V2WbO1fW6EASJWQM1HBJeZe265txdqT/F9LEMK4Z6LxXGb2tuiCsjqyW01U3qOHcEB6QZfUbxb0SrC+9jIk769N5BYmpvVNwrTMWq8r57OEm44gsVIraAmmROyijv6E1e2xsagf0xYt+UnEHlpSqDYIZ0dhIdPlqup4jGF6Y/8+5lqwPhRbBYw01D6BLlxzsXysKo/OPs6fQa/ZUpJMFlVL1nkDs7v0RJPmq2qSi0wNPLhIhbInpSH5vNj+NlmB2OvY6HvLfLisgjriuEgP+8WKiRptEIOKkUesr/b01i5dpuaOm0JW8a+/C4iFU4nj+FesEIcZYpsFxgxhFryj9pqrChyfoU3++fJR7uUvNPwCnWy1JkRd3S7BEtE7+0oWYrh+FCpFhBeujI8B49zt62cF0UTinJ5U9kyCVPhClIPvPEtsqqHsvYxhJ6XhyFzd2XnziUDO8BYQOUIYQFnJg/SdwkxnUJvYY0Q7Oyr+ckl04c7zPUl6QpSSsKrS9mFO2n8foBznywZ7XT0ws3vN81quFVtBPBR0d8QaxvDV/R5YWisyFiDhvforZ0mwIKrpM1TFyEbEAFweU4X2cx4SxB73LHjzyM8UKJTgx2l2ifBJO11D436ntXyqk1XwH1eA8VI0Ly9pWDRv9V57mCs+khphdq9JkZsF6/v0/ytpk2BNJksuUIL/Q7i5+Uc4H9iI0InTQFDKhR6M6JPGLzV91u5b75epHUzWqNB2B4+gKtuUe2BBcARA/WBw2dqQW+5JqOD9lOzuWhmFgV/j0vkm0vx/SPnY/TbxhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0471d-1147-478b-4d87-08dbe221ffa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:19:45.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InAhqI+IdQGo9b9FqDEq69m1X9zZ26+LA7DFSV1KHtwFalMEbESkiODyk5wvvx7SY4yr8G4wBNGuMu8E+DeEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100162
X-Proofpoint-ORIG-GUID: TQjUUIXbSbLAUty0Tpj9KfbZ9VUvrXEV
X-Proofpoint-GUID: TQjUUIXbSbLAUty0Tpj9KfbZ9VUvrXEV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 10, 2023, at 3:18 AM, Martin Wege <martin.l.wege@gmail.com> wrote:
>=20
> Hello,
>=20
> simple bug report:
> nfsref(8) has no means to set a non-2049 port number for referrals.
>=20
> Expected behaviour:
> nfsref(8) should be able to define a non-standard TCP port for
> referrals, for example in case the NFSD port is going through a
> firewall, or is tunneled via ssh or other means.
>=20
> Actually behaviour.
> No custom TCP port can be specified for referrals.

Please open a bug on bugzilla.linux-nfs.org <http://bugzilla.linux-nfs.org/=
>, product "kernel",
component "server" with the description of your enhancement
request above.

As I said in the other thread, this is not an easy feature to
add right now because the mountd downcall is text-based, and its
parser can't support the punctuation needed to handle the extra
port setting. (If it were easy we would have done it already).

We will be able to add support for alternate ports when the
mountd downcall is converted to use the new nfsd netlink
protocol, infrastructure for which was added in v6.7.


--
Chuck Lever


