Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9A75B314
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjGTPjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjGTPiv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 11:38:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF233C12;
        Thu, 20 Jul 2023 08:38:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFF0W5023563;
        Thu, 20 Jul 2023 15:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pxFBqc6yQoZ55EhiV1IM0VHiGwGqoYNcIQK4CHQ2zII=;
 b=C3gaDjawIuQEk4jmL0VKJePJ4V3wMTISySmi9UGopGlz2wh9js+m0aH2yWySzmyTlk9E
 xFuklKC80UiWDOqAO8RxMkkcabqB8sv5xMjJmYe5it7lDOAC2lPNfCj9dabwqnmDX+KN
 8MVUQHxja+jXPWPEaL6XPq1OEtphs2UQ/KDoFu+Nuv8bswD5xO77dy+jyfNUn0HVDinQ
 YukM+FqMEawAywaGHGtFaxBo10YGoyBI/loWFCQcq55DA6ArGUgnwytsvDajEXxkBx4D
 NWNZ3QLQeET3q89txH71rBsXXnbn03x+DA52Hi+GHNXn0Vyj2Zfo516KpINuQj/ObrUm zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7723pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 15:37:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFWI9Q017454;
        Thu, 20 Jul 2023 15:37:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8t7dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 15:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdGRL7+DbjP4Wgm3tfRCy2V8GWJYv+RIAy+Pl3ViSl407hlGtkApzv0GEqeHqRkNqPsgJOMcpmqC0dUbaF8yq0isQrH/cLItl0JECCQ0qXNE/WSAYgwnPnVgL2iL2AtTTSkPvf9wJsv5FbPqgv3J/un4XPGmzEztTitq1Oy9QC8xifVZvlqZPpltZPRlhdE9kkVhV78Ro3fmm24allwIsmYY5TL0Q/ofrHA+Ap+9yOoFg1j8dVzWFZ8jaOo/Hwh+o0bmRzhnsi3qJR08Q3ESIklD3wQvuoVpQ2FtS8eYI3mfIT0Rc6/OzooF7DyFctAKjOhPg6UDNVh2l2oSuHEf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxFBqc6yQoZ55EhiV1IM0VHiGwGqoYNcIQK4CHQ2zII=;
 b=kuHYctH3oGxNJWJ025vWFyTJJTIskQNYeJzjhUL+DvxusW4uSlDifwfMXONZcFoNjvgoSJjZDHpXTrvcOs2qZ4iJkXmRhhNxI6vaotWSk6DQY47CJVzg6Es2j5NdoO0HnT7aFCKQVPpZdJR4oiQD5B9dHogCw2IMJnQDsAcXjY6oBk03DYGtRsd284+VbfOxNDhFH3Y/S8rUc4yIA5/HPKTKTwI7V5WI9dlF5RPGoDCe3q4x6rb7gBE+tGQQKuSXjeCIykRB1eDLfig9u4SmZ2TZOfYrsBrimus297LVn117a7ts3WfzRIaudwUS8/vL3s9XogfuVKLjroRcRfZuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxFBqc6yQoZ55EhiV1IM0VHiGwGqoYNcIQK4CHQ2zII=;
 b=Oz0REwMB5KL0OB0pG5WP8SsdZ0CFkczrOSJOtw2IGJ/cF3sJONZX6apHyQcz3voOJzYb94MI1W8CQ8lkpZAaZnemvgQd8UZeszXj0lAuHCkwUJMKpvIbe7srU2iDMV7P1srG8PLTL4Xrep8cTi2Lf771YlCzRQm4Ju1XicPQUv4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 15:37:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 15:37:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Subject: Re: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
Thread-Topic: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
Thread-Index: AQHZuxrUUcSB+OrawEaFlgaCCuixU6/Cw9WAgAAE6gCAAAE3gA==
Date:   Thu, 20 Jul 2023 15:37:38 +0000
Message-ID: <C4A9048C-C3C8-4C62-B68F-7170C6CDC5BE@oracle.com>
References: <20230720-bz2223560-v1-1-edb4900043b8@kernel.org>
 <4B067A0F-93E3-435A-A32B-B17BC07D4606@oracle.com>
 <061f2b988de3da1dac32ecb3d8ac76319065b51d.camel@kernel.org>
In-Reply-To: <061f2b988de3da1dac32ecb3d8ac76319065b51d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN6PR10MB7442:EE_
x-ms-office365-filtering-correlation-id: 880198eb-a7b7-4f3d-316f-08db89373f6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6outb9VNSCZbieTMnBjfWiyaFIjRqoyi07wdkArlEJXt1IISYH65/EWpLp+dEesNQTxV2wY0hc5Wngyjw2X9C3WVn7GeJARspAxYREZRexf5TivuWxZ30FQJO4iFz8g8U/iYaiG4wqKN6PSePBzaYdXjIRvG/DA7IiJYH29J4vhFN/M6qVHoFYcP65iTY3QER7CJ3Ry1UM2llJ+gv0tIG940v84mxcxV4x+jx67rRPBWZG+xIeXEKkfcC+OJjzwp7R//Ub/34VkLfOmfvFczyyScoNBaha24qRJPfA+vSu7jDgrgmBp6OLyZ7thswQ+I/IA7H9JSWBLwLR3Xi34OjK2t2DpnZBR5FRxf+dhnMDgFBgIELy0nQQ2aoDDIcdOaB+2a7J3ThPVf/U7WkhHRm8NAeVqL8WobXrWsXz8PSrMOSdALhvc2TEWAgndKKTw6O27vQS2tUPjjNpCk+9dfjO27jceMDQAmXvg7Zh32+GCzdiajLdNXKnlGij254l30mign5SJ2DDAZMsiCxwp3pqDnjv/Us6luplZ5YWBF/b3JJF55zO/lXZOV/jqCGs9614WVtSdGKH2Zjv/XXGTMQvGbmy9ujwi8lr53u+HwyvX40MOvZQ3Bw4JCvbih32eVqQYNx3ExjpUjpWH0BIAnpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(2906002)(6486002)(71200400001)(8936002)(8676002)(5660300002)(966005)(76116006)(6512007)(38100700002)(41300700001)(122000001)(91956017)(316002)(66946007)(33656002)(4326008)(478600001)(6916009)(64756008)(66556008)(66476007)(66446008)(54906003)(186003)(2616005)(26005)(6506007)(86362001)(36756003)(38070700005)(83380400001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7uYbJqZ35BdntHbz3AN4NTUA8kcfrZPnFm8ByMek2A9LboxBPGgTKSpWiEAC?=
 =?us-ascii?Q?evigs4nrYYutMbbBa2D/Aha3NoHYwZGX0IT90GGMWOebHVVshjp9yFlewypt?=
 =?us-ascii?Q?JWDqVoMZRjD/VMDl5JwgCfdWZsOKV147PPp0TnCmMMqJtn4YyyqMirQxFCw3?=
 =?us-ascii?Q?byDW3b0o3lMLWceRBDfCbMFqhRA6VwvJ0+aREUkRKvadFCKXa/7xy6fkiSTr?=
 =?us-ascii?Q?AHZsZAM0FaBXy/XaHUZZRq31n77gIudvNNsOB4mXbfBbN/v+EWtRK7yHTfa5?=
 =?us-ascii?Q?bhi8ywQZJYK5S5tXmUeVpQRKgcsIZZMZWXAEfn2NKcGImdPkeHG+j46Drqli?=
 =?us-ascii?Q?tipVUzG1f0Yl11S1n2M+6EJ640I4H4y415JHLJCoWMoDRSnX5Evv10MKhsrf?=
 =?us-ascii?Q?gM2VJqxlZk84l7mJ4DEXDzcoEh0qVb9YkpGL58PCro5pVxw79pc4Q4gZgSQF?=
 =?us-ascii?Q?xu3t5F4QjukrQjTmCpoZK9hIJZ+I/3cEz5ASaYt1Kdx1WYCNLK2HZUn7QJpY?=
 =?us-ascii?Q?+IXE4V/R7VzJBaThsNB8+K/cmMPnigO4QabVNHYcgLbmmI2I/3Ai1PrWvz33?=
 =?us-ascii?Q?11zbuVpPfnpfxHEMj4MdKMS3c77YuvYZUH/9gfS35wytk4v6ihTOe+Po6wJv?=
 =?us-ascii?Q?64OeeKy6FbneHhKIfv9pcF04M4rpvyQ4oZDU44Xtx8zoq2vUukLmAuP45LJC?=
 =?us-ascii?Q?6BnX1bNr2mVRLqHCMKKUs1jTGRzSl9Ce9+CT/iPyUBd85iEEcBayKhwr53Np?=
 =?us-ascii?Q?+dPzMoFHbdAFEfWDgqhgJP/JhaA3WQdVvJ9iu1OcNxYCNQTHtsMlWDG3JLCf?=
 =?us-ascii?Q?Yrb4BMZ71b/wfeSnkf7ItzBX5g2aKifu3hRQyCdQTk9DvShvOGauiPlrz3Eh?=
 =?us-ascii?Q?MGZIla/a6RTxXtzBOjVjnd/EWsRxWIYE80lLaIn26JeP5Iwv4H73LTQoYjei?=
 =?us-ascii?Q?R6XdcuZA2lrCqp60ypJpi8W/xvQNRsiQARzZCUJBdfma7EyAaSXUmnDLPlHr?=
 =?us-ascii?Q?oihQwS1HFPDL+KwQmwgbkAXS8uWe3xdpOkBewDprPXYr4YzH4+N5X6v+RAb7?=
 =?us-ascii?Q?1dsi7VTzxMKhBtbf+MKZ6z37NIm9zpxgsAsAr0LflC1CcodvzqftItNAv9Gx?=
 =?us-ascii?Q?G7upq/0YjUwyXCPV4ZGpxLiWMnOQa8krM/nDyGmDv45RvqYzDAPXvHWnWkCl?=
 =?us-ascii?Q?l8YwDcQZezn1OA/iJT00GvUPevmxrHw1zrmFSPEDZJiqiCikz+x6aWixfT24?=
 =?us-ascii?Q?G3Jv1tHMZ+ML1Dxo4A9CwHiM0jGhJsEsvNnQPxq6Lrn+BXJlIrvwYz2i/H2q?=
 =?us-ascii?Q?o4X18GtN2WeERV4eaDEoFSGhhao6H8D+HEa5GSuYJK18mU8wtPiWlkPtUYYp?=
 =?us-ascii?Q?YJvJ3+g5KcLh5bo++KJmLYgryLedzlIREl2PyGlngpHKnlKwkYdRXRlLswib?=
 =?us-ascii?Q?IkbG5EkC+i8HZO5GwFgJmHNxaPMS60jQwOaqQDgdsInKxCLUUSl6b4YRKaAn?=
 =?us-ascii?Q?OtqPA2B3CyLZk8ebO1IyjU+T4QFRA5VNc6ZVj7ptKYuIFG7OmS1uL2MYIbdU?=
 =?us-ascii?Q?GdpRouphBaFw5XsFDCS0MB/DH18noc/BA7k59iA4QA/EMqK72xVs7ZbER0n1?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E50F0BF6CECDEB41BC78423F0CC289C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K0DblmKsv4yzc6Nv0U9qI+LGS0/EDAsdVXxZWmsRGgBPIXl8RQ5Bqbsd7C0BLwVZtfCuzbTbzbmg3L10KX5U40J0uwPrINkqFfYshvRAAzd6LnyQ+PVPdst8lGKLChVf176vQUODwT+pMJm4yx6AG+V/4JWBi+Fl6/PnmNLjmOO7nFP/DtpPnk6KmbBvXQ11wwK+ynMF/xNxyHjN/k/erdFUY5O5fag9lgQvn+l82B7KaLfley4rLGgzmtCeulXV6vT1k52b1PhRQ77yHy92THJqJ8Yi7uF9tvYifPj45A4YAf/D9hpYURFW1tUXMTS45/tQZGECT861TKG9StKGHnkdc8ckZktfNj4+YEGnd3twUQvWJ8QE70giGZtGtKhs1kVaUYFqRk8X0R+aP0GpSIoYJKc7nB3AhlT7TWDOnvhHZqVtWLXcuUX1KE/QWjXABHQ69m3oupv4IXwJ7QZ2Nj5Qag4rkqgp4rAa5qmUNWLFCdXKKmQBHoad5bKCJbosMUTzVCDRpHcZYvUfHI0IR9Rqw80OfZM49J46/EZs4yRMBCrWRkG0tAAX/+ACNwjn7ksCDpD9NgxXvhmDfCLlozReeJV6AL8NJ2gf4ArLblMOLdR26nYFwSorVeG2vsG+wqGwD3IlmBD0pOaqsZM1mxWllzrHJLmSQEdineUHi3pEg6+QIrcoZ8JVrKdWBX5+m5zU/FT7cENwY+GmI/ajzV2g5sSy/IULxNB07PsLwXzcycU6NFrBGt7zHWIEnXqvguR1De2MFlLXewkbuZbcMq//uAsBY2LX0sZZseTzxDDft+NJEm90IvoqrwpUa2Q5mN7sojarPaK73+ZxQ78jbA8njua7W78CQuBeZIlfJlM3IzJQ54Yn17zM+v2BmZe8D+DPX+kBgH+Fc9BdsB63KQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880198eb-a7b7-4f3d-316f-08db89373f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 15:37:38.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdVNJ98EQqhbMv7PNZ7VQLhZofk1Rqurg9NXDnu6DCO4Dlu5C0/GQzG3XjbNCARJ+xz7/UbvKL7hGNab1bPVoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200131
X-Proofpoint-GUID: kKG0G8TaEJXqKrov5RwYFTuBdVbGPTtA
X-Proofpoint-ORIG-GUID: kKG0G8TaEJXqKrov5RwYFTuBdVbGPTtA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 20, 2023, at 11:33 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2023-07-20 at 15:15 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 20, 2023, at 10:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> At one time, nfsd would scrape inode information directly out of struct
>>> inode in order to populate the change_info4. At that time, the BUG_ON i=
n
>>> set_change_info made some sense, since having it unset meant a coding
>>> error.
>>>=20
>>> More recently, it calls vfs_getattr to get this information, which can
>>> fail. If that fails, fh_pre_saved can end up not being set. While this
>>> situation is unfortunate, we don't need to crash the box.
>>=20
>> I'm always happy to get rid of a BUG_ON(). But I'm not sure even
>> a warning is necessary in this case. It's not likely that it's
>> a software bug or something that the server administrator can
>> do something about.
>>=20
>> Can you elaborate on why the vfs_getattr() might fail? Eg, how
>> was it failing in 2223560 ?
>>=20
>=20
> I'm fine with dropping the WARN_ON. You are correct that there is
> probably little the admin can do about it.
>=20
> vfs_getattr can fail for all sorts of reasons. It really depends on the
> underlying filesystem. In 2223560, I don't know for sure, but just prior
> to the oops, there were these messages in the log:
>=20
> [51935.482019] XFS (vda3): Filesystem has been shut down due to log error=
 (0x2).=20
> [51935.482020] XFS (vda3): Please unmount the filesystem and rectify the =
problem(s).=20
> [51935.482550] vda3: writeback error on inode 25320400, offset 2097152, s=
ector 58684120=20
>=20
> My assumption was that the fs being shut down caused some VFS operations
> to start returning errors (including getattr) and that is why
> fh_pre_saved ultimately didn't get set.

I'm wondering if the operation should just fail in this case
rather than return a cobbled-up changeinfo4. Maybe for another
day.


>>> Move set_change_info to nfs4proc.c since all of the callers are there.
>>> Revise the condition for setting "atomic" to also check for
>>> fh_pre_saved. Drop the BUG_ON and make it a WARN_ON, and just have it
>>> zero out both change_attr4s when this occurs.
>>>=20
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2223560
>>> Reported-by: Boyang Xue <bxue@redhat.com>
>>=20
>> checkpatch now wants
>>=20
>> Reported-by:
>> Closes:
>>=20
>> in that order.
>>=20
>=20
>=20
> Mmmmkay. So I assume the URL should go in the Closes: field then?

Yes, a bug link goes in the Closes: field.


> I'll take out the WARN_ON_ONCE and resend, once others have had a chance
> to comment.

Don't miss the other comments below.


> Thanks!
>=20
>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++++++++
>>> fs/nfsd/xdr4.h     | 11 -----------
>>> 2 files changed, 30 insertions(+), 11 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index d8e7a533f9d2..e6f406f27821 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -380,6 +380,36 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>>> return status;
>>> }
>>>=20
>>> +/**
>>> + * set_change_info - set up the change_info4 for a reply
>>> + * @cinfo: pointer to nfsd4_change_info to be populated
>>> + * @fhp: pointer to svc_fh to use as source
>>> + *
>>> + * Many operations in NFSv4 require change_info4 in the reply. This fu=
nction
>>> + * populates that from the info that we (should!) have already collect=
ed. In
>>> + * the event that we didn't get any pre-attrs, throw a warning and jus=
t
>>> + * zero out both change_attr4 fields.
>>> + */
>>> +static void
>>> +set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
>>> +{
>>> + cinfo->atomic =3D (u32)(fhp->fh_pre_saved && fhp->fh_post_saved && !f=
hp->fh_no_atomic_attr);
>>> +
>>> + /*
>>> + * In the event that we couldn't fetch attributes from the
>>> + * server for some reason, just zero out the before and after
>>=20
>> "From the server"? Is it only likely to fail if the exported
>> filesystem is an NFS mount? Or did you mean "from the filesystem" ?
>>=20
>>=20
>>> + * change values, after throwing a warning.
>>> + */
>>> + if (WARN_ON_ONCE(!fhp->fh_pre_saved)) {
>>=20
>> Maybe you should clear ->atomic as well in this case.
>>=20
>>=20
>>> + cinfo->before_change =3D 0;
>>> + cinfo->after_change =3D 0;
>>> + return;
>>> + }
>>> +
>>> + cinfo->before_change =3D fhp->fh_pre_change;
>>> + cinfo->after_change =3D fhp->fh_post_change;
>>> +}
>>> +
>>> static __be32
>>> do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cst=
ate, struct nfsd4_open *open, struct svc_fh **resfh)
>>> {
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index b2931fdf53be..9e67f63c5f4d 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -775,17 +775,6 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)=
;
>>>=20
>>> #define NFS4_SVC_XDRSIZE sizeof(struct nfsd4_compoundargs)
>>>=20
>>> -static inline void
>>> -set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
>>> -{
>>> - BUG_ON(!fhp->fh_pre_saved);
>>> - cinfo->atomic =3D (u32)(fhp->fh_post_saved && !fhp->fh_no_atomic_attr=
);
>>> -
>>> - cinfo->before_change =3D fhp->fh_pre_change;
>>> - cinfo->after_change =3D fhp->fh_post_change;
>>> -}
>>> -
>>> -
>>> bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rq=
stp);
>>> bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_str=
eam *xdr);
>>> bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stre=
am *xdr);
>>>=20
>>> ---
>>> base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
>>> change-id: 20230720-bz2223560-9c4690a8217b
>>>=20
>>> Best regards,
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


