Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2762E201
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiKQQe5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbiKQQee (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 11:34:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D945CD31;
        Thu, 17 Nov 2022 08:32:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHG4J8b028268;
        Thu, 17 Nov 2022 16:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sRJDzSE9U9UOwWwtopqsdxDsGeuT+BEIh25ICLR5FLU=;
 b=mX4Dj8xts+jzzlz1YApvC6ryNlT7xpCzLNZhe8wuDj/7Uojcki71V2sOR3vxWpZpnGrk
 HwVw34ftaRl6Ea9+9aTqoISbiwvzuZFB1qGxvS59X6QBrH9G/MOEUHBz864yuc386VZh
 BwMyApTt/h6/Vu3S6l1zO07fFFvI/LE37bUQWFQDud/9pBimisJaHEfN36UnltubLpzG
 j2dqW/WpxM9YYhwsYtURhWDWGD5992xrtWuJIwuF2SXZ/qqsnTtztMoreIaibNI/wwEY
 4XS/VtQqyD3MGyTyUOAykpUV6aQP31PBMNpqlERkuFEsUhZqLsYHxuV6FMdq4lViy/DN OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yksj7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:32:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHFrxYQ010866;
        Thu, 17 Nov 2022 16:32:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3ka5j8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZhgMC1z77QdYzQtXzOiAvyXMXf1ulEOXTiNwzJpOKklWRCDU98GtZWRmpH2otjjh4bjQqa5OLFqEWwkkUu6B8okJXW2WDYEjzL6UjpvBLaWmk9oel5IG0pNfWcAqldnFLF42HUw7LHwnOHYM9/3KFaP7Q+0XELu4A9nBbGXXqnMNfnoYJh1dPl1J9TTGHIAO5oHkDAgFDt7fkxQs37w4wa+8p15cSvjKNN8tLxuTtlsqRsg3EVjblTv/SUlSfZQuRLozSvJQFJuOgkIbNqdRxJrRMqsrLxY0ZXTVa6hOs3+MSbBmPt5I9Yz8A3SfJmSUEsArmFjpjrSbz0qtIi0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRJDzSE9U9UOwWwtopqsdxDsGeuT+BEIh25ICLR5FLU=;
 b=OkLNfim194UvFCdLGOr6kb5FF3eU038ixH7T+jc4Iyx/EI/CW7reyBAIcd3fpKsyiOEKTkAE16Fu59+8w5NCriW9Su5ZWByULGGO5DsHrz5OQtFrkKEripKb2LPmVn6wUP39WvAtJv0JzZ7Ja6N4pMTko2WvMNxrtXSYYIIInk+HtwUtdz5pK1NiUUCh+1M3zM5R8uSrsLfJvXCDvQCAdYtfEpcUNGHl0E/ncg/FBufs0vWtHEuTvlgUyMixbreTpL7yDCSqI/W+JkAaQZKKEGlfeQysikP0+2ZJd4l5Xa4fe3tKKuPxr+Ow/ty3sRw4Z5fL0mne+Tl70kinwPLAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRJDzSE9U9UOwWwtopqsdxDsGeuT+BEIh25ICLR5FLU=;
 b=XqvE7VkyIGfLREAljiyZshd7b+0co61NUPnGt2gN3K79kaoz1zHF/oD5sL087mcFc5PbLGi7KMDT2gXwIqr1Yc3wYE/k3lK1zyors9vfLKbAzuya8C+WYqIpUvx/actAwpJKWm1j5ZNixsRY8C0fspzfrueUaY1VglNG06XrFF4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5209.namprd10.prod.outlook.com (2603:10b6:610:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 16:32:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 16:32:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd round 5 for v6.1-rc
Thread-Topic: [GIT PULL] nfsd round 5 for v6.1-rc
Thread-Index: AQHY+qInYeW1mSwVHUSJBQLRmMkcbg==
Date:   Thu, 17 Nov 2022 16:32:15 +0000
Message-ID: <F48B9C90-E689-4896-8B57-ADEFDBCF9FCA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5209:EE_
x-ms-office365-filtering-correlation-id: 3f0f59dc-ff57-4c3f-3ee4-08dac8b949be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoOW8XKvtsfrHjpMq43gnCRbjyJwkNW2fbVKYoNLkI0swxvFUQ8RZVr9/ChgBm//tsEHM8YM6G5rNl86u5TeEs4ZQJmq+6uLTAEonwW2z6lvHPbgsfeLdM0zfbWKIir2WCC6AEnkktssaYBaXrTVJBYgl9fVIEcEM+kIL5RnmLe+BsJc+NyQm9ohn/o0DRNoF7RQtZD1XyE2sr/bZkCihiRsalvN0uMqvvLPkXOwztX0Euj6+c2y4kyMfT3FQH+RQNl0EcezIQduj3azGbajWGoX7UyM+Zcp11Dqs8TAiybJkaeu5bHz7J3c8CUy/tmAI/c2zDgdAu3VSnYIiJVI7d6xW3NYYUecpXK1W/CXaV99hQpJpcrzBBaghsrENA8TT0XvPu9jcJ/8eYVe+cYl21NZwjzfq7K7UYZ/7phTvG8KXX7obIkB+TrklmPE9Z0pb4r1Z7nUBYhn+AfAGSIovjuzrVAhuk9BsOLcdYOQkXfmUWWtPrkjuvScPGOEZJrIv6hvz8CCvMW0byVelLjyc5v4JVuQVNhJVnpIHJ4Ae2wuqwLgBW3U28p9FOkF2uxY61NqTk0zys9q7ZlBfBmzk1NW2p8cB52nfaUkE/aU1m4oC2955PcK6Yn0/a8fxM646quDIxWBJznqOOhLYadalS4Z4Vxi+bX+hLeYglBRxDWnrJXf2SAGMlJyPJMD1CbD1Yx9ZAXiQbt76cxN7qIztWWNR3VmIMa/XYiA7mXzqMM+1/T7jqL/y5QD2jsUuG6Q4xL6mq0fmvFWWCsP5Xuw8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(2616005)(26005)(33656002)(6512007)(6486002)(316002)(6916009)(6506007)(71200400001)(36756003)(966005)(478600001)(38100700002)(54906003)(86362001)(122000001)(186003)(83380400001)(38070700005)(4744005)(2906002)(41300700001)(66556008)(8676002)(66446008)(91956017)(64756008)(4326008)(66946007)(4001150100001)(66476007)(76116006)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ueRjUZSeI3BzzmBfjtkZhBSjZYQoEru8pviS97EM1E+yViqTr8+5Vw5mhsZP?=
 =?us-ascii?Q?N0k1+Nc+G96xtiRDaMhhGX58/d3AcRRuitap2qZ8H52ff2fR9j+ivaXL2riB?=
 =?us-ascii?Q?ylcUCppkpdJVHW1auRnvoFbQt79TyoixbzqxlH6183gGEkzCjVRkpuy/1DX5?=
 =?us-ascii?Q?oR+Ao+k+9ptule9o87tGJ31HvatFrXOhiCgpltS5II4C6jR/2BdoWukSRJjW?=
 =?us-ascii?Q?+88kUzpK4Hwn56NpPdPIR2NEJepW6kCPD/d2Cu4FUBO3IXjV+2jKMWYDznCp?=
 =?us-ascii?Q?YEypoTLZyZlIR877Ro500srGMnm17t+z98ovI1PwCapYUAa82gXs7X5Anjnz?=
 =?us-ascii?Q?yVVz28iaIKRhKZiA8hjFwp73KmsANTsTEJ9136QAP7heRt0YDYqxgv73eNh9?=
 =?us-ascii?Q?YxFmyJGY/6Uwhxm2WqKR1fGvCLjpyu7XL60XuwtHz+g/ViMOEdiA5sVNOrDm?=
 =?us-ascii?Q?RIDsAwRqPBRQ7IPGESf/OxoESTRWZzl5431CaOCK4tQu3SmmWV3Xhs18dmJ0?=
 =?us-ascii?Q?c/olSvMD/el+qcB2vwrwJnE5Xsid2l+AF1FjaHdz7i8nk1/M4lut/PNnlNlf?=
 =?us-ascii?Q?atrzo/zLkMfKeULlN8J4smkBt5FVJAq8tp6dmI5pE472khwu1FzjXp2BOrv7?=
 =?us-ascii?Q?eJ+6QC0WxKXyyh5dIn1cObYFkn8lZ7vhuOb0slKgqkTiJ6KJgq41iaEl4ETe?=
 =?us-ascii?Q?a4JF1o/3vzbey6ZzawPcTC+DdMTQ6o+YkKucqWD+B+wUrZY2MM1TQ/259Na+?=
 =?us-ascii?Q?kYVzpmp8BB/yJ6NN8pRhizjv/AtHAk+Ef9FdxDU2fqQMqkNkkyUk8wp0aEb+?=
 =?us-ascii?Q?UA5S7LPEwYu2q9LtY7Nig+T6VFdw32sXeQZNI2+k3nDL6G5tO2QN66HWe21S?=
 =?us-ascii?Q?c+hMRihkSl6uTjUKInpsyo8TQiVOOeuuPm0MSxPTzsALYuCUT7ZD8b8L/m5k?=
 =?us-ascii?Q?Ku5r3KmSryjkkr6fxB/XMx0EDH6M5IkgALV9z6r3YnzS3/eh+8KKzF9H/PF4?=
 =?us-ascii?Q?bcNb4yNWM/EPBjPVElsdyutxoEiYyE3ALLiJsuUWWMH0DUPAPUzmrIUV28px?=
 =?us-ascii?Q?aQz1oQEZx6UDA1O5ZZrU14S14F16qPMX95QbX6IQLb7yCBBtLiuWjYwpUIzW?=
 =?us-ascii?Q?BdY+4gOAHeJuJ/PH+qZXiP+CpZItvJ0i2iRJoqzzJ986JgdVqJmk8u0KSr80?=
 =?us-ascii?Q?vyyIv4//VtLdwPZ69WJYbDgG2LK9jy97+QWcnMWJKfpkEEDoe4hV/FT3cCd4?=
 =?us-ascii?Q?3ESczsjvgkQbwRFharz1UBrUAXe4gpt/DlhVJis6yRcdUNb+7HUDlqxg/wCy?=
 =?us-ascii?Q?Nxwzh3RJJO0iuHpuRqVGcHJUf02zkGQfsuhu/kZdNK/sI3CLzBoRKQhPf8a5?=
 =?us-ascii?Q?Yt2f3Ua9ZoX+p2fwdnLfTlFcOmgkEcBpu/YqN7ymNobMLNFfxou3m1bpG+Q/?=
 =?us-ascii?Q?R9i6fodTHSREw/omdNTOaaBu8Vm9/5cb59S5OYlzDscJPgbnct6YSwZjgBxe?=
 =?us-ascii?Q?BsFyH0ZeWukTnKXxm4ivm2ggAUZDGo6cjdsF/nTA2z0dT9ut2jSqIwey/sDL?=
 =?us-ascii?Q?27qgmEZtdaCRKWhxEHImnXLdDbfHgEZffkTSGSRvYR8pxiRv4RWA1Swl4tk+?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22FDF31321570E43A83999FAC0F1EB9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4sUaNCQfQrcM8hvyBIlOZlk6kMlEVh1PKAWBkzDLOPWNkLmOO/fjIa9EGPnB5l4BLcvvW028+0rUFwkAXBMIu00njh2K8Qc32hJPzR9fXE84Gq17p+zW7jauSvTt2NXam3spglxbiU1lzAVvO509ciY6duPs/rcsLo8zzIA4O51xgG+CUDaAV+IqUfBdVQYumdcEJKHw3yDNgr9kyMUX3s7rPXMyq1bsCncwiU2CwVegLkvSRj1l29mntEjlZsAWrIFkifVOfTbUn9PjcFNvKwQG+sarPCsGQ+Yy/rgXJcIQzoVdtRO8t5COmDNggkR58dfxe1u91p0DergITzf0DsfOj2j5CDejfQ/D8f4e7R5YZwYkSkt+gj5tyURWiZVXZzI6nvONsqGH3/sa2CTulNz+p2z5SBxpF9A06S/jbQ17cYIVKjolyqNm7cYX/DMGw+7tA0CMI+/o14ivQd08yRGnstbxVuOtcXOmGDOn852iWD7ZFOS+slL8Zj1mQs/QO94X44KPxWjoWsz8VdlubBrSig7QKJbpUXAFHxqeOeY9yoJE+9jUp4eGD0tOAT1Ij/Ag6e0BTQGZE0x/JiwdLnP50dbgAc+3E6lV/ax9+nksq4BruZAzSeO8nJtBnje7Rl9QE33Nb4fg0Um/TRRIv2xxAuR61XF4Zp/vkyM2RggjWCa0uyhQv+FgirsbQnQ1ZIkn0sf9L02aNFiOv82yzC64mgIXQOfIMb2z/7tvSS8K3Mr7BYe4nl9JeE7T5rVh/tfNY7GrD/GElucWcHjj2YdVFG4JaWsPKqeXNOV+DFJxh/SchW+ltrmhAl8VdE/ODRl2uZezGomsxGJGae0Gb//6pj+Y1dJ4zXwRl0H9n/e45Gpo8p96fkxLeFEig1bWm94RmCTTE8+dT2aU9RUNbQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0f59dc-ff57-4c3f-3ee4-08dac8b949be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 16:32:15.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGGQiC9CkKD/HbNmMln+atsln1HDVLfMLx5l1no0bL9n/ub6uFvA/jECs8n8Xac9rimaOPwWcFpwxvSiHb6tAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=878 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170122
X-Proofpoint-GUID: a5xgmLCp_5KnlfMEoOQ4F4HHTKxV81Xr
X-Proofpoint-ORIG-GUID: a5xgmLCp_5KnlfMEoOQ4F4HHTKxV81Xr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 50256e4793a5e5ab77703c82a47344ad2e774a59=
:

  nfsd: put the export reference in nfsd4_verify_deleg_dentry (2022-11-08 1=
1:32:53 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1-5

for you to fetch changes up to 5a01c805441bdc86e7af206d8a03735cc9394ffb:

  NFSD: Fix trace_nfsd_fh_verify_err() crasher (2022-11-14 08:43:35 -0500)

----------------------------------------------------------------
Fixes:
- Fix another tracepoint crash

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix trace_nfsd_fh_verify_err() crasher

 fs/nfsd/trace.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--
Chuck Lever



