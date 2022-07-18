Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74594578579
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiGRObt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiGROb1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 10:31:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8822253A
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 07:31:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZe2E030990;
        Mon, 18 Jul 2022 14:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ez1P9eJGFPtdDOS0dEbSgoOdw5fp0owH68aJwUG7M6E=;
 b=LXup4HqR2Vt3T0PHIToY1tw7m1cb3KKG+g966clrgkNfcmnp/pqxQGz3RCVQb6lr2DJQ
 vc4MtDGp0qbqwULS0fDvp7ghDIWHhW3R2XKEuK7dMVC0XmPzVrxhvxyXv1GpuYAwSrjW
 kDEehyMCfEQW+qiwt6P27JIl7zvVeE0+WdhioMMSa0cV5ebmLtXTtnaxlNQKzl8CCDJZ
 WHCQIKygBTjgLzd50vXyEGbArvFUKjurO/zAKPiDWJaH2iWtRf0FrtXUVmJQjdWCrObK
 p20HLiFFKPjAutU3xRy+YPNy/cwt9s3fUAoPvRVpBj6tSWJCHA7T7OUhb2f44Q5j7Jiu VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42bf8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:31:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICajKo006541;
        Mon, 18 Jul 2022 14:31:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gfm7ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:31:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBtigPOYmFnSo0wPMHJIbfzsianPR3VA6QQXd80odyjnJJ2y+c5P8CzroD0lNvmSeeyTgE6XlM9QeL8IPTCa0nwCSTQitmzscjShWafpxvvcxReKfhMcSsOm4neXdrN/zKJuD1Duj0AlBDQCxrw8h54OcoNwqhwI7WITdFzUDBNc6Mfmq0UUklMqJ77RpBEXb+CDXI7caG5IdPAXKzBILVreVDFJNV9h25mKrY/SnsXvcOShjH9ROu21Ksmta1B6MzW2Xg8x8zLG8wneFnfwglSdJ9CSx2HoKuNzSSs+BjXmXQB/SWrvHeBeMOYofRBjuYO5bFLp3dl8LHPjcKQbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez1P9eJGFPtdDOS0dEbSgoOdw5fp0owH68aJwUG7M6E=;
 b=Zkp6wl+quCySJ6oY3ugPgmXTQuRJN7XNjvN4D21gowxswIE7QXTvw1suweVX2t5NDCJyByqKBhijlkzIU4GCAsVq2yOTMcNLOYtGtgNsESlR6PbSNTiB4+QZXoshIbGElWQcV9NVpczw4Tb4fZvZap5DIVrv2fKCd6NcQA7QEXnEMGXWbVqQ9tUlxd1G5f+7sDE9lxeiV3tvoVbFvRQRQn6b6a3kLTRS/Aax9a2X9wKY03r/UAv/0K3/EZ0+UUZnaJJPgOR4x9dQd9de46Ljgi3OH1cufw8taSxZRpYaJq7LWEMkzYzZRMqiEwpMaEX7DWolDf3rlW3BEf65YIUkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez1P9eJGFPtdDOS0dEbSgoOdw5fp0owH68aJwUG7M6E=;
 b=ybmvcDBDG2+/HwJxb+r1wJtcYpP7omy5FZeo+cpB2mRt7glK9edzGaFn4g7T9DoN+1+UO14ZmR/pTou67MlTtdGvP3Smv61Xewdde9RJMq5YIZ4IcLyrCA0RwG/nHrb0SBHGHK8ZjjpvnmDBXRt9w6O9Nc3XO6/ypXTikciooTY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5427.namprd10.prod.outlook.com (2603:10b6:303:13e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 14:31:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:31:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd: close potential race between open and
 delegation
Thread-Topic: [PATCH 0/2] nfsd: close potential race between open and
 delegation
Thread-Index: AQHYl7z1JceZQBeLPEaYIaQ49Rcxiq1+i+gAgADBzYCABC3RAIAAuw4A
Date:   Mon, 18 Jul 2022 14:31:13 +0000
Message-ID: <A5CC699E-040A-4017-93BE-51D3E1BD9B0C@oracle.com>
References: <20220714200434.161818-1-jlayton@kernel.org>
 <165784314214.25184.13511971308364755291@noble.neil.brown.name>
 <c10b61cd59a940dd93f6977300ab0d3c6742320f.camel@kernel.org>
 <165811450205.25184.16800980627192339653@noble.neil.brown.name>
In-Reply-To: <165811450205.25184.16800980627192339653@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7677e3c-2165-49ed-f510-08da68ca2a9c
x-ms-traffictypediagnostic: CO6PR10MB5427:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0A0ARhBjt+dTX9LTzttOXQh6X+5Vz13MVlVtDv0rEfaDBDUr4w6qAJqnm8dqImipyVBcw/xTwkzbwwSH5wp9t9Nna2AuPNZiHYiu2K4wp6/H3Ny2vvcRjhClyfaLltLXtliU7d5Zz1oUdZWwNu/bJiCsmqKjU/T8kUftBYys7/eIwA7B+CRo/p3vQQsTenIMKrfWLGU+c20QvVgT+QxaHp0jRk5XFf5+OqZ5/8B/zhlpvmuZKqPcdhBR9DZ3NmYU+SZE/6KR4DQ1KI1b9FasJ7184977RlFZVuvCI2nFBqh9IGdtWoQg/68mDL12TJprXbdZG3vTZdXMCRmy0U+KvTnx/KUiY7bdYGZRglZKZmv1fDg05OYDJVT9pCwXR2oHBJUpqIYbl41LZbyx4pBwgYoX1OwmQiw35qDONBD/tgfSuCV8NFSwCJjsz2q4AUy901UdW/mUQfOu8uyMB+koiDfrjR/juIAanPxZJClpg6nj+VTwpBYQ+5LN+L7hZmAga9J1gMLxS4/1xS3+WaCXn+aN36zoWrX+9YCy/Fy82XrKPajnPs70+q6E34zdQzyPJDkw15tDVhCxyi9D7OLhUuCn5VQo6MfJIinsEsxTXjkShS0eYxc1BKJRvV/cKtoBZE6hg+DLWkyVDl/UdELFUYflps1ugjGKkxekgWxtFw+j74FGkNF3GZoKfykJVJwr+yHmQUHacVprV6CLAU6Wcg6YgxfYNX7MtGS552vFmIJ5gBP3xYo5iLYUNR0cbPl7/0zAVZj+Gfj6H0ikdSbTNACDK7TE9maT9sBwV8XBtBVGLIe/pPbi37utDOiDZfG0diYO70YVD3nRuKO6eLXy+/m7SzZDQzCZKPEYBt4MhEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(136003)(366004)(39860400002)(5660300002)(8936002)(2906002)(4744005)(54906003)(33656002)(6916009)(76116006)(66946007)(8676002)(66446008)(4326008)(86362001)(36756003)(64756008)(316002)(66476007)(66556008)(91956017)(26005)(6506007)(53546011)(71200400001)(41300700001)(6486002)(478600001)(2616005)(186003)(6512007)(122000001)(38070700005)(83380400001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kfpQglCPlrAfNw2Rsg7kmxb4B5V0yh7QVC9DaEc2+bdneEmmdokPe73RplBr?=
 =?us-ascii?Q?OnwIDoy7bOUZwKJe2aDfAdFxh3o24Z0ZM5zw12SQdLETgjZicwE4G7tw/Y2g?=
 =?us-ascii?Q?dM/cjDpxhNbc+oJF2S3rEfErOoxKzjgy31C9oiTJ3IROMkd7QBW6iG3/FYCj?=
 =?us-ascii?Q?FzaWsQ76wBTIVwYm/9d8JIqeVm7ykXdtQJazUrELfoANkSg33aX6GtsaDW18?=
 =?us-ascii?Q?e2wfI/9bDiteiBUJpmXtUfaUcybaiuVr/kAeyVKEVLJDbjEHyY4hiaFCGhzP?=
 =?us-ascii?Q?XlG/3q0M9FO/5qvN+kFE08tfn8f0lvRl+5gnQUkdlRW9gWkOjorChIwS6S6/?=
 =?us-ascii?Q?6rBDvbiPMTcNC3wvDGv8tfMcBivBee6dy8zLpT0pMuyk5geIM1HEAfVmaIOJ?=
 =?us-ascii?Q?nE1d+HPcTp7k4axD/6oGk5X/8hLyVO7wY7FUtyikg+4CDZt2IY144Gr+b/A8?=
 =?us-ascii?Q?9QwdcTmRaTOhurA5dUfLbQNXKrgoSPEnxFv4SdsjjJXc4ZZSZ5heTMo0LTuj?=
 =?us-ascii?Q?CJoZpmkwoxN0C3bltNUwfy84rhpbRo5XNX0/GMfNP8kirFW8bt+XJlZYy9c8?=
 =?us-ascii?Q?lJfjbD5iINCiWmQ1Xd7WyUemrlhI7csEms473oS8GNub0GjDeVKwocPtn0+f?=
 =?us-ascii?Q?ccPx1487v0l86hfrYyuZ/X3kzUJ4GEbqq3Oq9FH3nJ0Sh+8genHkcoJVGRdA?=
 =?us-ascii?Q?Gj+nbWT0ukKCIPV29YbFy9YxxCx+IfpkQ5LBKbHdOKvs5CIQ67W0ZCcD3rCq?=
 =?us-ascii?Q?To+jLT9xbKRGC3b2XtwIrFP8ikYjVktZhztwmJjZTwMxeiH152uR80wY8+oK?=
 =?us-ascii?Q?gjbJT6J70HJ679j2U+GnoCqYNJL9Uv43UK2QBWv6onjzydN5R5T+9acw0Bzl?=
 =?us-ascii?Q?BJ+jzBffIcAygbVKz/G1tN9UbFU3gkgYKNWdjY8Vd9ksBOwDVsxe/yN/Hol3?=
 =?us-ascii?Q?CXXsMaG0NPr+gO+6+CBIINnUQQCuabgB6bUOTaQgSbvp6eXWXyAYMKptQ+7K?=
 =?us-ascii?Q?YNFWkG/OIzyRwUfNUtr7RtBVJT+FBhMPm9ouWwSDQsFbMt83tasfwp3WF7Jg?=
 =?us-ascii?Q?hbnfXXJ3czhAKQeRECHidfdjmUq7BXywtt9SAMkO3X9ifrkRJ8zBii6ecOdJ?=
 =?us-ascii?Q?YGZJ/nh7jpjCRwFrobFjK+sM5ymdpiXB3Tuputd5P53DsZ+KmMzUvqDpTQdp?=
 =?us-ascii?Q?/L0ur9D97SfUviLaOreu3RM5bg2egf4nPqqbYzqlHzVVPiozeLNaVkb3/uqx?=
 =?us-ascii?Q?8G+ycYN1M8OyMBTt7MuxGuPYWxsFMdh6vak4pAhItUygAkFt/eZO4vvsDqUG?=
 =?us-ascii?Q?9w49AsQlB1G02RbrSymIo759P1AOdTu6maFEhTFYGxjACDEfK6macTo4FuJK?=
 =?us-ascii?Q?2aE9X6xzuKL5fNajPR4LsvGouPtWagURp1SRhPJ68/w1Ckykm69h/LpXf+qP?=
 =?us-ascii?Q?4BYdwWtD5DKwD00kDcIPqYsZV/qHL20fy3pburZ6XBMcHcCCzrIUZqBFq1Bt?=
 =?us-ascii?Q?Z0UkwMpevwqUgQNSwELnQgI8p4XbQt5BS2Abk13PjNSYziKPvmN9cOAL34P0?=
 =?us-ascii?Q?WvQlTjhoytUhabgTGVanrHqHFDpE2MyulHrTNGm9W6rPN7/0GNSbi3f2oxU3?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C47366D9175DD947A4C2A9961EA11224@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7677e3c-2165-49ed-f510-08da68ca2a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 14:31:13.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdVdQFv8wH71TmPXTNuYTCywbsFKOfKjWloq6J50FHwuqjj/e5ssGrjZ5LSpxCqMcmuQcvVDOKkM2gyZNmFtPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_14,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180062
X-Proofpoint-ORIG-GUID: yyjSjWevSQdSW21SUI3JaAg-_Yt_EEUY
X-Proofpoint-GUID: yyjSjWevSQdSW21SUI3JaAg-_Yt_EEUY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 17, 2022, at 11:21 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> But right now I have a cold and don't trust myself to think clearly
> enough to create code worth posting.  Hopefully I'll be thinking more
> clearly later in the week.

Thanks for the update!

Here are my plans: I'd like to finalize content of the first 5.20
NFSD pull request this week. If these patches are not ready by
then, I can prepare a second PR later in the 5.20 merge window
with your work, which should give you another two weeks. If they
are still not ready, I'll get them in first thing for the next
merge window.


--
Chuck Lever



