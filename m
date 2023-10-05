Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A77BA2A6
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjJEPpG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjJEPok (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 11:44:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590C7243D;
        Thu,  5 Oct 2023 08:00:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395BhrTb014803;
        Thu, 5 Oct 2023 15:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LI6Wx9GY/0/db7FLgKtlCLGXMJNLRN1iWBz7vNY2lDo=;
 b=pYjl+xXIZdjYlyfDJ6T02E0uSgxk4KCjueLw05vQgoT+HHDUHvdIRvyt0D5+4b9+Wlj+
 TcTGU7R+X6Dxv6GXTRxkTQWShSXMUXMkN/XEZT2ixFT36toDDvE4Gy4RRpyRT3QkoYmL
 iK3JzqTKpjlshyeY7OQblTK0NaOg41capto+kLdn71V58ezEN6bhTn8plfeP15T+fmoy
 9V5OxFtuJFVyT6KRBcE6SaBILxG2SC6nGlk3FnMQ7GzqFfLBuONfc8y5C8DQvZB9SFm4
 QkfW5Azj+gwI8kRJwO1MvtfADSYeT2ywsIn7+D/h3FZU+VVemv9NShCfyJ59zjnTvgOw 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vhpep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 15:00:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395EVnL3008791;
        Thu, 5 Oct 2023 15:00:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49qjee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 15:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIlf6VOvJ2lQIAaC4FZiedSNZmu5cIGUsx55uhV6VMij1IGaxsdvNMaSFCeBXFROTI/sYiO053ugQonm5cZHulY5sh+ESfyuVkCHSVfII0SNWijereWC6rwwK+Y20HlZFjTeXAeP3rOqAXLaivIVd2nWgCjlCVjwl5Gu8AyKl56Zm9Av/zV+FfwiDc9/z1Z3QgqSqJ00pgvFDcKGUS/B8IoAMtzlxlqmDqVrpvGrqPevyK4US7NBv+sXr+hO0ye8U4ScGy9pOZAoxXQ1rezDBYMhdhblj3CQwU/kzBkDQFYYXoVsCsgleAx8OvZCUfRJCT3Ed+mCtn9hxTtCcMt2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI6Wx9GY/0/db7FLgKtlCLGXMJNLRN1iWBz7vNY2lDo=;
 b=dsfXtqXRx/b6rKWX1EFlN6w0WThvNm2vllxVIdpEbZ+8pD8s4qKgxRRGgfjNijUUeMIK1AS/aG7bX4yBE5wE9phDemvgbCmkc011EM98mouvdzxGXO6MsgR7Jpa0JPhr3FnB2WY/BdlYyJasBiyty501U+AhayaMiTWcXuAyY6ncSIzrWFpToh5TeQtAJd0yWVxx45FmbuMpKnkO295zBYiYZwrpRRQjBjdV+HHlq5Hremv5jY86CJs4mEBZ3u/14pL0l3fmqJBtQ8TeCySkG7bFRrkahYESqn3MC1ePRH6E3wCpTmxqbG2OEdo/pRW1rTJjDrQqoAxiXbWVQ5WQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI6Wx9GY/0/db7FLgKtlCLGXMJNLRN1iWBz7vNY2lDo=;
 b=ycH3qc/mfOsN2P2hS5NZXJn0wdR/+s0aTjytTdHaXkTPQ9stoxxwtmLLMuDGufG/L2vjCu34jRBN4i1ZXYVam7oJ7dnXFZnOi0+MA7vw8CAyIebnFOeh8iRkNdxOVmWXblS+3BkXqtVkeoD2BkepDW5Slcg6L7LX7w9SGHSe048=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5377.namprd10.prod.outlook.com (2603:10b6:208:320::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 15:00:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Thu, 5 Oct 2023
 15:00:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] tools: ynl: Add source files for nfsd netlink
 protocol
Thread-Topic: [PATCH RFC] tools: ynl: Add source files for nfsd netlink
 protocol
Thread-Index: AQHZ941bkZDgXQW6cEuL+nc+Z8XG6LA7R2yAgAAC1gA=
Date:   Thu, 5 Oct 2023 15:00:41 +0000
Message-ID: <55B014D8-3FFE-4A64-BA61-407B6D9E9907@oracle.com>
References: <169651139213.16787.3812644920847558917.stgit@klimt.1015granger.net>
 <20231005075021.0da40d7d@kernel.org>
In-Reply-To: <20231005075021.0da40d7d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5377:EE_
x-ms-office365-filtering-correlation-id: 785d1610-2c04-4420-10c1-08dbc5b3d79d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SvYc8kXT/fmKIWWZuAbNWfcXYnt8dOH3vBCycTKV6wbHNv/aAN5UhZEs0pThbwR4xX3PIlVrKnr2li0eNcP3AEI8zJveLILDgppcLb70/YgvlFzE9qvAyHUE9t6Zj3sUSZQ0OcfxayrjpulcOvCMe5XL/F5SOvbZhoVnhovwJgCQgFgEkGIAO+WwSEtvRXVC/VOy4seSesL7QbUIIObAkg/I5VQp1CgWJokb+3CJkTX3Kc5A4WX2Mof4uwFgnyC2GOkOw2DzLnSD969hEOxnryWiqFe5CCU+x+tH/igIUHBkZLKjwhkNAaCKaa1wjWnHyMJ/5bJoU8gbvRYWiY+lGpYemydOXju/Cg82CG8TAB+gLmMlx7V0tdZOUysEe8qbCQYLMp36P0v3MLIPJsXoYcRaGGlK13bkppAoYW76lwD8EqJm0qxwvfcUOWesW2wPmBqQk0q89R9f1MC0F0u5qUCKrXPlZQDLu4QIrj25Uwg4IDIrlzzxC33pppJsh6CQtAln4iDXsom1x9AQHYUQbVoj6nekDS4LI47Fmy96ylMw45QDR7aumVh2O7qWt61/i3Sxe6FvrmACc/5ESxLGEdFtsfXjZ5K87zRPk3Rw76J9KeoD9uidIfvXdLgx9cDjcbYYLHSfN/GOCbEyCK17HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(66556008)(66946007)(6916009)(316002)(54906003)(66476007)(64756008)(66446008)(41300700001)(6512007)(53546011)(33656002)(26005)(71200400001)(36756003)(6506007)(478600001)(6486002)(38100700002)(38070700005)(122000001)(86362001)(76116006)(91956017)(4744005)(2906002)(8936002)(8676002)(4326008)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZVEQz8Te6kkTXrMcl8Im6IB3UBNnvFg7zUb3BiQzZrqPS1s4SmCjrn4vqlmN?=
 =?us-ascii?Q?V3O20jtW2f6uR3E+70BaT6njFmxeMjEzta200FDAJIrV1X1adxLQNCJqXnk+?=
 =?us-ascii?Q?QcXe7qMc11YN6nkt/N84AxA0PPLOqU0fvWruFpTKynUGzF/Vs0aXkQqP2N0q?=
 =?us-ascii?Q?FWcfS3Tf3lwgTryL2m+kECU65ckTQ7EoEgJBCQTzPKj7ItFHuEvRB2b5IvrA?=
 =?us-ascii?Q?JS9LE9pPjxriKDYyBBW0NKpWUZTGR6FG6F+RnDw6SjIW3k3NDYiwSB66GwES?=
 =?us-ascii?Q?oviho7fhgwVr5Inx2FTS+wxV+o6jQF+qKuvVdjmB2jkwS72ydPCN52NPkOhc?=
 =?us-ascii?Q?x8ULVkrWbL8DkQ6a04nhuzVP1ItDzFwnuAp1SS/ExvecEMXUEvtBKk1oAIVP?=
 =?us-ascii?Q?DB7WKZJY6/zjztlE7kc2DKLKYLw+n1jUeMGNFARERKtlV5o9gtd42FydOmSY?=
 =?us-ascii?Q?Zt8SihIiTqXoeXyE8lzLakV3Q1Eb1YBRyt+hYB0PywckWa/hPSTZRNbs+4hf?=
 =?us-ascii?Q?/Lrw4mj8VLBn7+HTxy4HIUnPhejlRcJDVMTHkYUCY/6HGU1wS3fiuqeH4UXQ?=
 =?us-ascii?Q?Su/b9cCq9ZTbLgZtGMX0+6Qe91bwxJ27cXBjpsTCxNq5/kFmglz09qV05a7J?=
 =?us-ascii?Q?sbRWBhCeWKtFlxguM6cvPvxMEubQvGE6QkLpIapwfCgfAMwWVeAy0aq5xBPS?=
 =?us-ascii?Q?+w/SXYnE1xbwVmdYdg3lXY8G6SyhXdiPdrd3lvAm0qD0KVJAArBk0feCKpzY?=
 =?us-ascii?Q?/AXM4tHjA92xSMaOx7hsc+L12g0dIgM3DuJ5w6MuyeeEC0xW9MutrhF3i4ev?=
 =?us-ascii?Q?gM7Lk1dhQjCuRnxfzzL/V/x8UF0cp3mwpyp0Uf9/nIj7871hi3Ay2AXui6by?=
 =?us-ascii?Q?wzXcM7ULK+kwZzGxtT2/IYQzdwNVNHERrLGPPMNKYKf71kvvgVJAlfjWrBiP?=
 =?us-ascii?Q?WD2us21R1yNQvGaV6Cee18ZFfRLt1bQmbHarSvbIhtOU3R4Tqf1hihgICv4b?=
 =?us-ascii?Q?EiqShcTT3t7GrjN4NIvFRpWOaDuM/ONvn+ZQpF4sXHQ5SaLSkbjxLb8xdmqM?=
 =?us-ascii?Q?eYggCZMLaNCv0LciKt+0VY1MpkuOnGbbQxhAzF5ycJiWPrEesHw5wLo5+3RM?=
 =?us-ascii?Q?8+J7z41abJzFcuyTWBrtRc8Hdn5j/vG8oAXh2gFbnR6wV/dnr2nW7rpTmHvZ?=
 =?us-ascii?Q?/qKd9sxzLUeS5IgmBzlvNLyXievBF7nvdE6lHLBDZBklC5+df1GXK8epU9JV?=
 =?us-ascii?Q?+SGiV08EcneiyoldRoyNVAo5kUf/TspDXdUuJFMGOBPg7cMW0xDgQsqIiLSM?=
 =?us-ascii?Q?72/FceaAvWMOVS668oNWzdmvGj+GGlFbSPYy6/dfa/dJeiT/exgU2BWnTIb+?=
 =?us-ascii?Q?eEALnqPKSHQ/4iHyu+5lzfBpRKtDv0wQYj9SVdo6IIH/e6I75v9kCApT/m3p?=
 =?us-ascii?Q?QojwACG/emqEIEi9IyCD3aSCkffzbC4aAbGCyg+rqUu60Uf2U4ngC7MyZNzz?=
 =?us-ascii?Q?E69HDxzIrfIKp4zgCAPHJrGIpcbboPWlG+lBGwvYTjbW6geGdrK735IhdWxo?=
 =?us-ascii?Q?BF5rh3/MTI/DDpLTsrMQWpHYtS2NtFdbPyYfOhTwnIPOOsprFzCY2EQoVHZQ?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <145E0AA9B99DA747A5D380B71AED1807@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9c4eY9qx4TOn2rGoBO85nrSqIypltilqEw4m4K9r7ZKyZqPHQ9nYGBdCLOV0kKL47STxUK1x74ruWaJUwYS5nMBPaHSvw3rfuuse5BxnYw1CQQkme7/aoheQu8OACufyeCYSXnmN01j7RUIJngOMgtgR6qiRW66Fmsk/HjGMRn8T1RejcwxduPmFb29yPwAK9/QvUMXXwZRJd3+hlapGBJcntsVYhRcXs+zlQqvZK/TtfA7RQ8mjCwwZzbh3ZYDosnko+ixSjmvWOgAElcg8jmOuQi6r9MxX89B8HE9gcjnmp+IOY9PRaubOA+XCeWjr9D+dTInANGIGwqh3LtB664DokLKduBiZOc4EG6yxNTHhmz1bpAHcmFkdsNUg0OH+WCok7uglpUdAX+zDr9j3HVKEU0jprCBMF1McESplu+E2uve+kGCjPbZ5Q4YF/jVWZ7f5VflKzwZdREG/0bmKkGBsXbjevkETdKjctWsKFYG2Nz7KAZy1NCLp+eQMjcZSRA+fsPajWE4a01/LaBOusrBCxzPN6PuTjvfCbfFhdBqz/Lj3/rrKM4cmATijlFovkij2gRPLamGMlBVdNWbEVvYbdxwVogWwh5LlrNEkceNG3fXQsG7c1+emGvZ7fKQ8wWRsddNeOJwIwg31Q0Z8XjbLhGwYmE+sTAxMZqCxrsLS68tHLirdf8KcCAAbOH4SsQxx6n4AFkAipbQILAufHb+dg/q4v48EhinsP9YtDiZxnQuusetovMFu7HJPk5vEa6k9qQSVygQV075TCjcPQlt+istsC56rKHLXRVZfSHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785d1610-2c04-4420-10c1-08dbc5b3d79d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 15:00:41.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBq2G+u7+hM16gkV6iLNICl3dpbwHjemCA64bzqE84mbxc6MsjiS9xXXP7QHzby2uIgo82R2QTpLbVkvnQVJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_10,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=774 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050116
X-Proofpoint-ORIG-GUID: sRvTnCMkvT_Z-rdjuLSBRBl_T7ewBvoA
X-Proofpoint-GUID: sRvTnCMkvT_Z-rdjuLSBRBl_T7ewBvoA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 5, 2023, at 10:50 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Thu, 05 Oct 2023 09:10:38 -0400 Chuck Lever wrote:
>> Should I include this with the nfsd netlink protocol patches already
>> in nfsd-next, or do you want to take it after those have been merged?
>=20
> Either way works, I don't see any conflicts right now.
> Worst case we'll have a minor conflict on the Makefile.
>=20
> Note that you should probably also add an entry for nfsd to
> tools/net/ynl/Makefile.deps in case there are discrepancies
> between the system headers and new uAPI extensions.

Done and pushed to nfsd-next.


--
Chuck Lever


