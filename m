Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7185766DB
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiGOSnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOSnG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 14:43:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B757539F
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:43:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGHeiL027311;
        Fri, 15 Jul 2022 18:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EekizrdJEfEDb+kpStX2fOP18DEtxt6ZgFyLS2KPmCY=;
 b=NjZuKLQYS+EApizvap3mPIemzhS1Jnz6AMEZiRsWA3vN6fDx/zMjGDS+muCJjCN/HStS
 YJdF2w67S5R2oknhuSTtT16wImyO812PuKgmGp18cxMNw8OK22UUw9pTq87CpJyErWIu
 s4AOXwuBkltRHEfmtLMN0qEct1suivD/jZhxpMMAnmtmujHuhJTHDCpbnmXC9bTrfVCr
 M69Pjybf6afJ/HGbFhHhtOJPvRQVAm/PPGTzpcbBe6WCIpVm+9j45/AskFBHViP2Cj1v
 Ky6KWqcg/sbyvRiJqS86ikRQiLtNUek+7peSARX8xP5Hww0K7QN+5XmNMu3b4HtYqauZ KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg8jju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 18:42:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FIZvED013989;
        Fri, 15 Jul 2022 18:42:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7047pn36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 18:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuAX+SlmguxtYY5gfJuroWQFvWYFAkbNoNhvpYYSnK5oT41o0k6p3vyrY3m75Q8Dc5llBGXHd0SvObhHWcpUBsWzbw4xHPFt74t98CZ6RdFiN5hhoKXa9s5X9sTl9tLyIsev6iQm9/g7Uz/3fy+rf6vPnIItxYfFoUOpvx2i/X12MZGJsKd5okFluoPwdOEQ50sMnxuySWGsR+Slzo0JqheYhn3lXyPWJbErVeTQgO2EQPuoYIJqFJ3eqJ6WEepgyPeFMqwKPpg6FCcnEVIFwQGz8ryRVsKkuntqcEN6pMt/lHi94bw8rRCCiDMyhRGXBuH1Y9aZyRS0hOMqk+4eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EekizrdJEfEDb+kpStX2fOP18DEtxt6ZgFyLS2KPmCY=;
 b=gn456Ys7W7atJQ2r7BybNfMcuSpU8VIyB6FljVZV5xGAYWm6NRnnKb8GFs5lwJ2K5oC1uGLhX+a7g+TZeRUXXOuk27tyayGMWPDpwPwNSMKA+mzfX/3ArrwI8ULzXKTWdhaYOWxtRFK6XqdbcBjiHF12w+skBlLjfkq0JS4i/acLhmYirvUY5V/3wEW+H+bqN05cpruDNuImiiMUI22Jvzmn/flFSpaS2Uyr6hvZzpT9vwZtsG179/V5gDb2a6HXHLObVbD+NxuLylx/jTFSJe/i8uLDc8hqhNelGCbgtVIEDt7mY6OmI1w8SKpk7Y7aEQT/f8sSn8wS9cQ3jKHEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EekizrdJEfEDb+kpStX2fOP18DEtxt6ZgFyLS2KPmCY=;
 b=xQs3cGCTCIiabFqpOPmlKyh5DWCiV3iT9x5vxCiEvKzhpV8jRRN0/+CksT23/Rf7zt/rFCKT0gz1ajuzrOhUWQuzkPAWfTh7GxAzI+RBsJXNlQzJsHXMQOx4ba3Qe3uV0+NkVOLNAJ7V0mNzcG15+7KjSHrGN1ahHjct/EFxmSA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR1001MB2053.namprd10.prod.outlook.com (2603:10b6:910:3f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:42:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 18:42:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] nfsd: close potential race between open and
 delegation
Thread-Topic: [PATCH v2 0/2] nfsd: close potential race between open and
 delegation
Thread-Index: AQHYmHlSxd5rdSP4vkm5nlP8AEo5x61/xGyA
Date:   Fri, 15 Jul 2022 18:42:52 +0000
Message-ID: <6F1AD05A-B3C7-4B2E-84CA-D08BF1093F82@oracle.com>
References: <20220715183257.41129-1-jlayton@kernel.org>
In-Reply-To: <20220715183257.41129-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2feda990-8916-4d1f-a3ad-08da6691d2f6
x-ms-traffictypediagnostic: CY4PR1001MB2053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQW4i9yVsIQfOqfKz6rp9PbDckDYHK7IK/mvFQGqqw0s1DFA/43Gnba2+9mOwBqP71IXRO/ZgQnwXYZjCHlfcCwEqERYyQWWzcrFt3tDBuoJsTClnS7r5AnXNwLDCa5womo0oQAlvrK4MqtCiDp7sApKe1z2pXLZ+2kkzxqrY2plBzzFqUDbIC4bGDdNNACEweFqg3EuMIW08j86Babn6WaXOUK8oIOMoNOOYrjzDSWHuf8xi6ufdOtvHlG9RyhOOpstoNPRRKB+k/3z2nyPnzDxhnbm0DotgpAPl1+BMFy8A5oe1W82L0Ddw40BvvbyLxl4XXgn5XJPKjbiklLgLxgQDIqTnSxiLoMfg/qVqSw7v4tzukqaeDtpBLFgOuWYVmN8j+MyneCHCjbl4XEe632fgkNI5La86XSmQf2hrnlK6uESoCyqOxbTDBXXuVKM63q7Q6hE3TmUUuBJUUDjlUmh8P1S157YCj7ZrUqaA81/TrL3ahhNoX99lvn0oKkTourxgqtqEiSdwvC86ks0NM9cj2lsq47cRuDJNg9h2YbNzD126tD+z1+/hxEaatVexqEt3J3sSUhDQ6JpHWBtKMpNOkyQmL4lafX4Ekms/iUOYxKn6ByrjWNhp2rYiHFzsSbO0/npbpsi32gmagz2XdXS4b0zTl3NX0J9PQtFiWl4Pu4zsgW3wFv/YmoEuMUbn4d0GeC5QynR/fNCciXngV3Gz1mPuc7TZ0xPBWm7T8tnUJAA1EborcK8+9ysWhrDC1GtQEKS80Td00AZWh9N7R2PgU9aJGf6RZ4893866L+HhkukqA3qt7+UGgACTy4IQkGMpp3HIGbW0JaD1KuwUEvWRo3EsM7G8H/5Nx7lNCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(396003)(346002)(366004)(6486002)(6506007)(2616005)(41300700001)(478600001)(6512007)(186003)(38070700005)(122000001)(26005)(83380400001)(53546011)(76116006)(66556008)(8936002)(5660300002)(2906002)(33656002)(38100700002)(36756003)(6916009)(66946007)(8676002)(71200400001)(54906003)(66476007)(91956017)(316002)(66446008)(4326008)(86362001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Lee1rSFzZuMpKbrgCD8PIL4DIWwxMHZXL+d+xwTI5falAoEhHfsa9Va6iWV?=
 =?us-ascii?Q?FM+QGOeJ4BKGtxQfA0OqfQKxfGO9WvBABgBUy/bLw0ovbhEkl3zGp7T4XO/x?=
 =?us-ascii?Q?QI3TVAb/lZ2GlixNIiHeAm0OMeuJzQDLCu3pvYb+UedoSmJJ2cnG6mR8ZOkD?=
 =?us-ascii?Q?3FHsJLtdAuuTGbKZsXtXELvBh5Netp7G+T54efg74V887SZZzEJnSwYb96hY?=
 =?us-ascii?Q?aWGmTtB0DTN2EooGx/Q1GVunEwQiFdgG9QpLLelysgnCVtIL3w9jJP7CzBMy?=
 =?us-ascii?Q?KJW9q3a6Zat/Cv08lWqkg5G58iQQ3/t3xI2+NAc5RdPAU52/Pb8W/WEzjwwk?=
 =?us-ascii?Q?EqJmVTSJF+lBzdOGMADAmKReK1yUtZj5SQ7xZYIXYophTb+Bsqgl30h2IC5m?=
 =?us-ascii?Q?0ttWcQ4FJCNQ1Sp3AgDUml9Ty5MX3fqo9rJ1dRcLzjkEV24SWipC+mVSvDHz?=
 =?us-ascii?Q?NAQyt1+iaP0YkBilLW84bp0Xl4H9Xz/ZAwzQXrBSaF3unuiarJ4jLXnlsP2e?=
 =?us-ascii?Q?xOizLyEjkQTna4WFwlqZMVbT4mRZWY0jH90aXO4Aj8ILwgVk4i+Hc73CuOQ/?=
 =?us-ascii?Q?uQQ8tszaPdgQ9U1qHMYQ78hIFTpRZBAUMUBlX5XH8DAPxEI4/6s+p0ttUpAC?=
 =?us-ascii?Q?SzQGNvr8VjcYudsDjdosMRE/kQpUGptqmVpuoXO1/9cNpVkZo60k6TrpiV9w?=
 =?us-ascii?Q?BkGgWs6BbPyjqCq8WnIL3/9OHpNCs9ec45CpmTvQ7GSB8jIiI2Z24ylz8Thr?=
 =?us-ascii?Q?uWNu4axKTPxsd76iWrQwAs+50zn1XiECiwblxxYl9gTgFJckasbXPdYUjEb7?=
 =?us-ascii?Q?NkLjPrurgPVsAp6CFqk8wgctWLT1XoHAeAGLGrATakusRkolKi26ZNfHo3Jt?=
 =?us-ascii?Q?IjRybdX4XdlDS3dOAOc9Vvgp2EMGIcDoSZxHpSNAq+Yb3JOFbF57PI3C8w5q?=
 =?us-ascii?Q?Zk8fhx6pvXuv77iEJRc28wtz6ZA6ZN8pXBuxs/4BuU/Fv7bRUxKTS+/yW4qJ?=
 =?us-ascii?Q?focN4fylypyh/ko7y3/OPpPzoIOCeiXQWBpw5564BwMf65lV91CRhmZNETvf?=
 =?us-ascii?Q?kko3OI2ZGJKLAUEeSBsNUWeW17SWMmcStAE1arMKO6ftrDhbwPjxi4G+if7o?=
 =?us-ascii?Q?NoePELBsHRHIDa1y86ZivtLVeXBxdvI4AarYdtT6VZYqpWVy2LWaOt32u8dO?=
 =?us-ascii?Q?uMO0JEgYcYKVPvK+VumcAnh0XAp14lj1PWDKc7traASxm10G/ASLn8Ud1GBt?=
 =?us-ascii?Q?xvapI9Z2iscGrF3bxneb87DGNUqA1bXpz2aplvkyzMnrb91qwVtoecURTrv8?=
 =?us-ascii?Q?VBYx5/8vb7uIDwlum1vRgsblXVAw8zbQoxJo/gaAPs9QNhpuE368dwJqThp5?=
 =?us-ascii?Q?qDQsnFmWJXyBmbtlkWEOIM4+0vP5Xn8qL5S3Qkys5YjXpPdfSghshQFlKNaF?=
 =?us-ascii?Q?PwlKFneb8B4r3RCQvR2X6H7JR6UkraEyQ4p0uyb+Oy6+my1VPkCKCoMYAYil?=
 =?us-ascii?Q?sbGFUWlBSKpQ1w+wEmMrcJM1IUX46Q1Lm2xsgai5ABGNex3U6B/RMqZgbWuC?=
 =?us-ascii?Q?2cTBH9VK/wXLOwiYeyJBt6WXrpsYjU8JqzJEnv23VWFpnyy8q99Z2A+nERVC?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BCE0C4D65F6D84783BE108017282355@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feda990-8916-4d1f-a3ad-08da6691d2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 18:42:52.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udcxAkps5XnwkKSnA/JgH+vBSy9hRjwepbdsQMsXCA3pc9EBzBpMSL9DL6GVkth4k/q4Yk2SJQwHtnFqLmqiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2053
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_10:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=861 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150083
X-Proofpoint-GUID: 5QG7Z7vCVf9lwS9m07AeBmhDOx4TwLO3
X-Proofpoint-ORIG-GUID: 5QG7Z7vCVf9lwS9m07AeBmhDOx4TwLO3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 15, 2022, at 2:32 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> v2:
> - use nfsd_lookup_dentry instead of lookup_one_len
>=20
> Here's a respin of the patches to fix up the potential race between an
> open and delegation. I took Neil's advice an changed over to use
> nfsd_lookup_dentry.
>=20
> This patchset is based on top of Neil's recent patchset entitled:
>=20
>    [PATCH 0/8] NFSD: clean up locking.

Thanks to both of you for pursuing this work! I think there are
some good improvements here.

Note that there are some outstanding review comments (aside from
the disagreement about how to refactor nfsd_create) so I expect
Neil will be reposting his series. This is just to note that, as
long as your series is based on his, I will consider your series
as RFC until his base series is stable and pulled.

I'll review again today or over the weekend.


> Tested with xfstests and it seemed to behave. I haven't done any testing
> to ensure that the race is actually fixed, mainly because I don't have a
> way to reliably reproduce it.

That's the thing: we don't have many tests that use multiple clients
targeting the same set of files.


> Jeff Layton (2):
>  nfsd: drop fh argument from alloc_init_deleg
>  nfsd: vet the opened dentry after setting a delegation
>=20
> fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 49 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.36.1
>=20

--
Chuck Lever



