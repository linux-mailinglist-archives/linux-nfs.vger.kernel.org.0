Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57F572A6A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiGMAv5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGMAv4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 20:51:56 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2047.outbound.protection.outlook.com [40.107.66.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B986BD6B5
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 17:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQSj8QOzzl1X/u/N8bDKy/o5X1Y9HMn3mL2jaowMABR7ZPEptt+W2r30eFNBvKfptp21G1qCZOPIEQNRrc4ZEwVs/ZNCbYCd8mWPySMIZhSeN9wbiapvr74KvTYP5pCCwWp2F1TuwP0XBgCjpVivlFDViyi1SUtzkZCCpdltehlnwyUmznGWeI80BWxbGaHzY+rKvd0GOq3OzNuwAqC//oS/8kETaLabf/8aSARjX6GD713+nzWKUkRWV/8YvDSjlP7EEaqyWDII/oiLY284IozyeUyNByMqfX7acQCIU0o+167fPKHdKokj6KI4xr/UZHocSMD9bhHJNYkt7KFdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/W4HC+HqbhXHhi+oHb/1NDGsLjMMRxLeB+ROgULazU=;
 b=ITqDR9rTFnNgzYRx6PpJ9pfWGGNXxZJ7cnHkiOGPWA5Z0CxhcPFYw5OwBeZFPZPGymFu0KzBagHnNuNzX0bsEag1GUFS0aF2cfrau6ZIkoe/AMmAfI06WNhkctIaIYM2uu8yvzHbO4tFd1zlRsLpyrV8G/nVKpjbjthGyLijmQjGh9owKWCT7tFRDFqKDg5XAZ1NZarbCrdKzdfX3Kl+shcxO4mxGChGjuqtkpv0eEH3OAaKwpLrCF+8gmdCQ9gzvYbP+vuYFPSPIZ08JbmJSyx7seHkIWkTdEA+k1Wx+ZLcFTtwU+D01tfF6mhLS1gV2FLSdWUsnsC7m9bcpid5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/W4HC+HqbhXHhi+oHb/1NDGsLjMMRxLeB+ROgULazU=;
 b=FYp4oNzANvUz9dtQhleGRR9W2/P3LR0FKyJQX8mGz1efeN3y0BqF7Nsmu6Hf761sGDPP28mMbjEm1uBRdvKB+gXlw0uuN8rkWUmeni/7hRbPEHnqK8COgqrjiw0sEfpQSWpY55U+s7L1CXqTtg0DLJ+BFXtJzEz1/++S3m/yAJdnKGsUMD4gBA3DedM6w7BGuakQniA663eFaueW2D0IfamwxcAZIxOgwv4kQ3HU71lIg+36uUXWm8OqBdbcbUYH6m0Bb3xie/lVl6Cs9kP79b8ZwepZGu7o83vlaE4zTnCNa2UoLcpIHrbK0cfsdlrt6dOYKH0TVZYdqxi1qrsbuw==
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:81::14) by YQXPR01MB5122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:26::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 00:51:47 +0000
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75]) by YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 00:51:47 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side
Thread-Topic: [PATCH v2 00/15] RPC-with-TLS client side
Thread-Index: AQHYlewBkWG5LzrS2kS1h9a7pAMndq16wEWAgAC4gO4=
Date:   Wed, 13 Jul 2022 00:51:47 +0000
Message-ID: <YQBPR0101MB9742D7F0D54EB37CE9B476C4DD899@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <c9b6787ba9154d1f4c2bf25387a35453ad20badb.camel@kernel.org>
 <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
In-Reply-To: <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 24a1eb29-4ca7-f872-d687-c2c87a2459eb
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f281c8c-6f61-45d4-7470-08da6469dd89
x-ms-traffictypediagnostic: YQXPR01MB5122:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFE7RsSJivnPZ05h+gkDAm6kBu9CWSHkWuQ1kImGFOyngJRlHbeWQcI57/B2RbV4RFMmth5B6cUfMPKahExtHLbWKEGE5gc7wTllgPuyZesX1Nfy6FP7/wPhQj5j8MxOGkDYiwjFyD4lZP25YMP0S+2DMgdGeJrf4H42Bht7DamxVjUOsNY1EwiOHRdhatUvSmAql7bhOQF/d6CrEyXAnPUN7Y5TFtPv29b41HgRPuO7w2dtIfaYVu0DDcD2OkgahfE2IZOtAw0X82rdT6rLFYnqtTCGWbQyTsaeDdwoq3H4tD+JHzULMZSN40Pp66682JLv3GPNnaDiF6KrAEJUHOCN2n6YUxltQBRHbCkgRfFfS7cDjStNlNRxJa2n3PzoTg9chH2wC3cS53s54WL0vJguTU+NxXcqPhdT4behvlYsAuJQGvobl7seLXDOBWshGAa3tx+pRHzu8eURgRkA8NDbaR5YIA3Wot/oe+OUrtfuP0zDyrTU3bWH4tNAWSuydingugMje37Bz1WTbQy3E9VsIipzjXr9QUx0AbBYtzqyRRtgvc91L3Jd2IzMgQL/nD52Tpnnxka+CEjTs/ubEgs21XHy+2vxrVKN9MD+5sCEK9Kk1j9u5r7LRe/e3guhlDvEOtkfIajBJjJEJ3VXG9SAEs0PK/S3NYpw6OGk0iJIM9nMaYV9j2T4TxUPS0Kn7k9FU9qOFe2wqmSv0T+L5Wv3F2OUVCv/Vl9+pgDFcsfyc11zdIw0fO6neL4rAiqcGtPRUYHciuAb0Sg4qZU7QieCv4fM9qpa5jEJx8TIVwsmZ3jZhOtsNrU9nMHJ3Zax+V46BM6TicwMK0K2BzMdivyBRapIyQb7JTQjg6N1I+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(66556008)(38100700002)(66946007)(71200400001)(8676002)(4326008)(66446008)(64756008)(66476007)(55016003)(316002)(786003)(76116006)(52536014)(966005)(8936002)(5660300002)(110136005)(54906003)(83380400001)(478600001)(33656002)(53546011)(41300700001)(2906002)(41320700001)(7696005)(86362001)(122000001)(186003)(9686003)(38070700005)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?anYZZxRiDWqEZv4WRXbLn2gbyZCGHjiB6yELpcp9UbCwjxw1Nt4Kju4ZXYJG?=
 =?us-ascii?Q?aaW/h+252cTyVUlxA8hOz3WWn3rCi524Ye/tucRyvkdOh5uEqu+xOKib+Pas?=
 =?us-ascii?Q?BHsbw2dkeEHUnNQJfwNwlXxCyreQCh7SQZYr8SW7Z/mEGA17OJPfoYwde5bi?=
 =?us-ascii?Q?ZSt1XTO54cXGP6+6IDaWuxGpWc66T0jAnWAQFb+at5tIlDsS4KxfgQT09Bmz?=
 =?us-ascii?Q?hc+Ojfcf5gH0HMhDoieLjQV6LOKTUPb5Dl4sRQC9hJiluEe8S7k2f1QTS6ut?=
 =?us-ascii?Q?M2D1Y+Id4dQRvKNQ2+vuXeCuvfy4ENuqIKv2o6zOBXk2wd9rvBZHPxidO5rL?=
 =?us-ascii?Q?5wRSDtioYXGvt0GKDr2yHveGwNgh1CKXSeLlmBaqQCxOlebAH3kA4ItvRsK7?=
 =?us-ascii?Q?NDXmL99DsK+YHB093KfVjKvNnDn+m5JfcNlmIhw3UjvmAZiAt1f5mdI0vDnG?=
 =?us-ascii?Q?zwsSoqFoQ315ebKeB2gFaY7AwGECXe4EBc7s6xstg1K4b8zvEAdjiiWVzJjQ?=
 =?us-ascii?Q?4HqStGcRHxkZeEbLnf4+oSLljJDQUJXUrjswoHlhBwCiBQ1Veb8MSRsT+q5r?=
 =?us-ascii?Q?GZ8kfLZeniITRpczBIl/jhvDAQ4WMrTblTFgrB9t1HWiSA8O9i7I+qCD5PEd?=
 =?us-ascii?Q?fTAGW7WxVBt3z0gKmJ75h+ofyeUNHUCsK35GzGHv02vQeT2CEEfeFT9ktjKj?=
 =?us-ascii?Q?3plBucAfkPkF6p4SXjidEnXWE0DlOIxgn/iJOMi4pZsZ1h7VbWMFX2L7sO3m?=
 =?us-ascii?Q?sNt5GwJBVf6je+ErcfR59KXBlEzQam0977loA+SfoDYxZ2OoXzCOdLf/Dwbp?=
 =?us-ascii?Q?6ixHXcqOUjBm5e+rcxVsGK3WrE/rbqG1Ueli1F25RkZed2m4ceFP+jeU85L+?=
 =?us-ascii?Q?tFjulR7KmeefO6KXd+cvGu+GmsEdhxDcCZqBop0zEmfR5XdySWiOAsGNOZGn?=
 =?us-ascii?Q?Z6AKrSvi6orPCt+CWJVQzASAI6YFj47KheU/jyXuip0S197zODRA6dQ/8dZd?=
 =?us-ascii?Q?JhSTP79zVfMKrMUbCxZFKJgSJaO6WRWWhzW1P+nbTaJH21uc0kZrjCfwEAOI?=
 =?us-ascii?Q?ahWKi7wM26jrFW971z9xUt+A+qYcGWNCWUyfKl0dDsIXeitypoZmEAlkf/sE?=
 =?us-ascii?Q?JMiLPQ3DIr+/AnzPIIcLqWJ4sVQMYjBBOzcLUIXWYUt/ylgKX1ToQr2tovCE?=
 =?us-ascii?Q?GWqbJTuicP6or+3+z1A4oGKYj5AYJQEyaPYTyAn+5w2I2AmSenxJ5i1hmWPe?=
 =?us-ascii?Q?HYPcjaxGBW56LEiRLhISObC/n24PWC3nC6fCkpYEC3lQLrSOvKdcKDpmessC?=
 =?us-ascii?Q?N2iVRpZ+gvdIdDf5YbmdjBUGtK/fVz/6Qzw+snQ6IzNGXwvG05AKW+Sca4AE?=
 =?us-ascii?Q?zZb/cHIYSkoJORqX1zvDmUL6hwxA4NXgZRmLQI6NUUiZk7hWSIepCRaSb86x?=
 =?us-ascii?Q?gA1HRhUQx+UgPOF8H3/1qY+1HoLfVnb1lJ+86+cXPTTYx1b2zxJqDACQl5sH?=
 =?us-ascii?Q?Bg/joqZipm5TYH+Ti70xpSBlLGhKrTA6d+ANJ8bG4LZh/OS+XmQGbVU8JvOq?=
 =?us-ascii?Q?7VPcK+j69talR9/tlctTXKGpqbqlTY47i+uGZU+RbD92MDt1CDUxSe+vw/d5?=
 =?us-ascii?Q?z+w7MUwfrnqRogPLBWwyHJewQBCTdKk3m/zq60YmjO/V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f281c8c-6f61-45d4-7470-08da6469dd89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 00:51:47.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySMhYwFXiomMI8oc5pr+It+RgQ6Y8Rs6jCq8vDlO4Xr0+4NLjw6MLm7kiFKN/ovVv4DgKdeb9bzMRaFmFlojng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5122
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As I already posted to Jeff, I can put the server up for
a day or two at any time anyone would like to test
against it.

It now does TLS1.3 and I'll note the one thing the
server did that caught the FreeBSD client "off guard"
was it sends a couple of post handshake handshake
records. (The FreeBSD client now just tosses these away.)

Just email if/when you'd like to test, rick

________________________________________
From: Chuck Lever III <chuck.lever@oracle.com>
Sent: Tuesday, July 12, 2022 9:48 AM
To: Jeff Layton
Cc: Linux NFS Mailing List; trondmy@hammerspace.com
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side

CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca



> On Jul 12, 2022, at 8:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
>> Now that the initial v5.19 merge window has closed, it's time for
>> another round of review for RPC-with-TLS support in the Linux NFS
>> client. This is just the RPC-specific portions. The full series is
>> available in the "topic-rpc-with-tls-upcall" branch here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>
>> I've taken two or three steps towards implementing the architecture
>> Trond requested during the last review. There is now a two-stage
>> connection establishment process so that the upper level can use
>> XPRT_CONNECTED to determine when a TLS session is ready to use.
>> There are probably additional changes and simplifications that can
>> be made. Please review and provide feedback.
>>
>> I wanted to make more progress on client-side authentication (ie,
>> passing an x.509 cert from the client to the server) but NFSD bugs
>> have taken all my time for the past few weeks.
>>
>>
>> Changes since v1:
>> - Rebased on v5.18
>> - Re-ordered so generic fixes come first
>> - Addressed some of Trond's review comments
>>
>> ---
>>
>> Chuck Lever (15):
>>      SUNRPC: Fail faster on bad verifier
>>      SUNRPC: Widen rpc_task::tk_flags
>>      SUNRPC: Replace dprintk() call site in xs_data_ready
>>      NFS: Replace fs_context-related dprintk() call sites with tracepoin=
ts
>>      SUNRPC: Plumb an API for setting transport layer security
>>      SUNRPC: Trace the rpc_create_args
>>      SUNRPC: Refactor rpc_call_null_helper()
>>      SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
>>      SUNRPC: Ignore data_ready callbacks during TLS handshakes
>>      SUNRPC: Capture cmsg metadata on client-side receive
>>      SUNRPC: Add a connect worker function for TLS
>>      SUNRPC: Add RPC-with-TLS support to xprtsock.c
>>      SUNRPC: Add RPC-with-TLS tracepoints
>>      NFS: Have struct nfs_client carry a TLS policy field
>>      NFS: Add an "xprtsec=3D" NFS mount option
>>
>>
>> fs/nfs/client.c                 |  14 ++
>> fs/nfs/fs_context.c             |  65 +++++--
>> fs/nfs/internal.h               |   2 +
>> fs/nfs/nfs3client.c             |   1 +
>> fs/nfs/nfs4client.c             |  16 +-
>> fs/nfs/nfstrace.h               |  77 ++++++++
>> fs/nfs/super.c                  |   7 +
>> include/linux/nfs_fs_sb.h       |   5 +-
>> include/linux/sunrpc/auth.h     |   1 +
>> include/linux/sunrpc/clnt.h     |  15 +-
>> include/linux/sunrpc/sched.h    |  32 ++--
>> include/linux/sunrpc/xprt.h     |   2 +
>> include/linux/sunrpc/xprtsock.h |   4 +
>> include/net/tls.h               |   2 +
>> include/trace/events/sunrpc.h   | 157 ++++++++++++++--
>> net/sunrpc/Makefile             |   2 +-
>> net/sunrpc/auth.c               |   2 +-
>> net/sunrpc/auth_tls.c           | 120 +++++++++++++
>> net/sunrpc/clnt.c               |  34 ++--
>> net/sunrpc/debugfs.c            |   2 +-
>> net/sunrpc/xprtsock.c           | 310 +++++++++++++++++++++++++++++++-
>> 21 files changed, 805 insertions(+), 65 deletions(-)
>> create mode 100644 net/sunrpc/auth_tls.c
>>
>> --
>> Chuck Lever
>>
>
> Chuck,
>
> How have you been testing this series? It looks like nfsd support is not
> fully in yet, so I was wondering if you had a 3rd party server. I'd like
> to do a little testing with this, and was wondering what I needed to
> cobble together a test rig.

Ben Coddington has an ngnix module to support RPC-with-TLS that can
front-end a stock Linux NFSD. Rick has a FreeBSD server implementation
of RPC-with-TLS. Rick's probably taken his server down, but Ben's
server is still up on the bake-a-thon VPN.


--
Chuck Lever




