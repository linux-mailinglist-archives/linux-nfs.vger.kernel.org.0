Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E240068332B
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjAaQ73 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjAaQ72 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 11:59:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2130.outbound.protection.outlook.com [40.107.100.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B217F53B3A
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 08:59:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glX9lZiv56NFNFnFWLyp9Yq0NNA++KKdfXxXHOOpPOKuPAl//tVWe58ZJUEpkg5ECZ5aDkF8tXtthQLwHNFhYoR8AP/YxNNidCdJG9vhgMk219w0EaKYh2HSBm1Enl03aPiZq7jiAJFwTsR4LmmU5j5jLrdl52csFyTmwlEoI14rBaTV4oVEIQ7LLMlg0Z6dwdlqtZMSP3Yv96entaGGImcAEu0YejU8LfhgqA+Xyd8klo8XnDXdXsLpLnwXRCZWrEOP6+83sAtNMBrW3rp5fk4d6y1/M+JAyS+g87UAU4N9Ko0b/E1BswrK2CtH954zFZbzSAsGdq2vIlui726wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EEAT9AaQeyA1aOAzjrHlh7zEF1+oadtISP39JfG4MQ=;
 b=P6btgW4GpvtjS0o7PbGTeKBYPC0jBd/C7EFZFfK41KmLwXUuiikFwUJk02nuC3j6rclsidAOC5E1iopZVVPT4AVuY4uxQ48g7bWfJuKFnZvUwVZwkMN3XHQnGlDbDBbwtHRWJH0f+bM1eIQwjuXHk2soG15zfhW22uE1Nbn8K+aGgJACyYpbNoB0FTMfcOzLFujorQWGAn57dMXVmKLN1iAkZguDdhBH7x0rmeoUUJzZuDeV9RsOV/LouhgIeWoEDtuh1/ES1xlh8VtQLSFa4gwU4deKaulcTvaTCtI6tiBQ/LpM6xb8l/OaWQ8Wb28fUntd5Reu13/eiUi1aBJnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EEAT9AaQeyA1aOAzjrHlh7zEF1+oadtISP39JfG4MQ=;
 b=cRKikZvQ7BV13E5zYvaoP4D8teqBBk0ChwawuBubYKlvcuKkx7ccD5xzWg/BLgoumy2aA8RHhtcQQ48lwFLHEgOxepgwJ18cURm4nTgSAIS6YjLYYutsRjEbQdb7hlGvCc4lzGYANtaDVQ4LkBshlH+OEluDnyhB/aQcSJrZlY5qt0dkl6BIXns4/AUx68LR3hA2U6bXhu5lzCLqHxZMjKr2d/x5460xgVOTTrck6nIOutm8j34bLUwaCrJQvIgd7x+SLpVm0IkNZBw2eKCklE5uawwFEakGKVDNSJ9iuSulcWXXLFRUO+LvHr0D0ijG0cvsR1e71KBrd9faR9Adng==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by SA0PR09MB6524.namprd09.prod.outlook.com (2603:10b6:806:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:59:15 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:59:15 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64haaAgAATyXCAACB5gIAAAJ1Q
Date:   Tue, 31 Jan 2023 16:59:14 +0000
Message-ID: <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
In-Reply-To: <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|SA0PR09MB6524:EE_
x-ms-office365-filtering-correlation-id: 756d7bf8-8c12-4d2f-dd57-08db03ac7bda
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBRtzbQUAS15u267ppuU3k4PJsd2R/G8oE2uSey6hAE0avCrdyNw1/T5Rw+jyCi9rAFsOT/MNt1KeO/4J5u+NhHxJn8ANln2/HaQavKA0gQqaKunvMvP8hQrpxfKGefbBmR3/IDxWHn6l9h50emSXroe0O3nFjpnT+RRnTh7JJakm3NF4nZ9NLHTXQQkjsxzgnGMOYpc2hbjAWB065V/3G/47Iw991aD9Iyxr1y0y3cLA+QPjnEI2btKh3M2nQLFeljNHWzdyVotlBk2y+xDWcTVtgqMALAkemiJgCJqa856HJDlAKZrSqJ5bAS1P25zPjhBqtEzNVDLhEIgI0PylBqh2LSvQ6Wm1jRNMpu6Aiv9f5tpBCU8Sg5AyvyiKhnZJN0dv70D6OzHQF9XjY2z0kOYwbLm7VB/uPeXt+vKd3N9nDLC5s39j0+JK31gor6srYTds6r1RLdVFum89StD92vrbSNii3yTb2RxsCWx1nY3N7Z4TAmd1sdSu2lMKu1iV0ybEWVEfpr4e1M8RDMolnf9uaC7r+oF4+fSoM2R8Q8uuRG3PvcI4qcyqZBoKjImWp++15nVgC3eJIK1DH1B4Q5nSDXSFTZgXMKq31S3sB//nsz+R43n+p0A4gBFmM5NiB1ws1ct3tFUkISzJfgD9Y66RdXqtV979P0QdsQ0g9pKpwqUueESHXtnTRX6L5faWBtPKEevZGw3yKb00QMiRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(6916009)(64756008)(66946007)(66476007)(66556008)(54906003)(8676002)(4326008)(76116006)(8936002)(66446008)(5660300002)(52536014)(122000001)(38100700002)(82960400001)(86362001)(38070700005)(33656002)(6506007)(53546011)(186003)(9686003)(26005)(71200400001)(83380400001)(2906002)(55016003)(7696005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vVof2wp139P2Af5IiIZHBhI06pdF13qYXnrOTnS4PeyklmOd9yL+l+L2p8r2?=
 =?us-ascii?Q?IGo6799ouW69T0JM6OzQECf2f+m0jz25mvnf3yQNGVYBA4csC0jGwlXKmJGF?=
 =?us-ascii?Q?IoRf4MnCblbzyVSA1Vt3ZU14ge00G9DHylIRtqRgzcnGF5AYXEtY0yHpTO2u?=
 =?us-ascii?Q?YIGlRdbfZiSSqe0TuZTO6oeqRXcGGl/AJ/AGkWCJ9u96GMH00GvRFEyWczkv?=
 =?us-ascii?Q?wD5uOvT7K4XOk130uKecjupQYwnRQwp7bmqxp2J84KVnm+blynPvtuYVXJZV?=
 =?us-ascii?Q?UpBQ8LRrXdSk3Ht+kSzoUfc037QPnLFpMAbQEGAee1zu1VFLGcc0Xd/XeGO9?=
 =?us-ascii?Q?8i0Y72kcTtXjBGTzCqC5wcQcUyVarTtGVpgjYHtr1RlMkCeYufLx9TVCg+xt?=
 =?us-ascii?Q?RdBkLUTIkw/fhUpKr3sviDAITbdYelzTPIp2A7Ehj5ZCII6Wu9yfHWJpczIC?=
 =?us-ascii?Q?CFtKSNpQjMGcjdXaT1OATiIH9V89TWaUToRVM1mk1dbuLfAwph62NsRo6QYn?=
 =?us-ascii?Q?mm+s3T30o8S1QkKPtDB8gj2zl8gNZo/NRZT10uDocHpaPlTXWfPwZdGLxzWj?=
 =?us-ascii?Q?iH3l0QXK1194WmVPtOiDrUYfzxy7XlqicsqQtp8yQb+1ME2L/nkG8zJ7XkBT?=
 =?us-ascii?Q?s6Fkie0mP4xdp7HHr3cT17bxzP46AYViILJqtecSlokToKpWXB9qyBbq9LV4?=
 =?us-ascii?Q?7vbH7yrZhB+QAdE5m+62xhKrXnPAfnRgYyOv4b0XBF5prObEB6EfrxXj8vUZ?=
 =?us-ascii?Q?NJJZKQiCKko4dfb25nzhqgTYmtWmDbXwP/Jawun7aAN9w5ihgmTSl7vZ/ZE2?=
 =?us-ascii?Q?Ml3P+iHbo442JmGCxGI/xqM25Yw9Ig73UULmMRqjuVrmpcoMspyA6rrExpY0?=
 =?us-ascii?Q?yZS5b8k8k9jZ1SCRt9huX8/WAdjD6Xiue1FZTJhMuhFY+iFVEvjH5n6e3v2+?=
 =?us-ascii?Q?TfX03+BB2VzcPfKOhS/WsPBuExAcivd9B5yFhEEWKBKbrJ+GhR4BPh0s5SWP?=
 =?us-ascii?Q?jfhe+yru95+zyDuzKOiAM3BsmAJC+3KSOONM1UvCiCHTwCn3LZnTwqBILuY4?=
 =?us-ascii?Q?gALqQDmLL+0K3mG5Z0Sc1WarsJSqFjnpYHa229QEOxGUQqnqpTfqPpKg7Qf4?=
 =?us-ascii?Q?IYRzAaXsNwPAKZ6ED3T08BW6QvfbMtHvXLICU2XujNm4hy4G4A71NVrxjU1A?=
 =?us-ascii?Q?5+TCdpCQB1flaeCh+Jk4ZTuIFMnKV9TY0k+Bu8ve6JwBrSrowP8POmMGT2ng?=
 =?us-ascii?Q?6YZJhj/szufN/PeUrJnp8Ah5mIaF4WRSTlWLKMZ0hY5wfTnMqk6aTa8T0WtT?=
 =?us-ascii?Q?DQsf+QlPsvGWde40Jx1u4McC4yj0fDgeVcVNctHpbU+AGP5FVXUAk/qt/R3Y?=
 =?us-ascii?Q?gb/uEAGek4cyVUuvq09XSnWDzLIxYYNc73/x1YcTQpolIieRdU68Fuc7maq/?=
 =?us-ascii?Q?oNEeZABn7Kt+wka1S3hnX35MkTW+wt7QggB4oa9dzVCtegGpeOQjbPN+iync?=
 =?us-ascii?Q?/a67QFmvqu2yPK9U52Rq+PVMUccpFjfHGLHTs0GoyrxhAlFPuznqVzjfRS9R?=
 =?us-ascii?Q?hr/3I/xLwAt+o2G8O4ugeuPWzuBR7TUE6hEPIvTh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756d7bf8-8c12-4d2f-dd57-08db03ac7bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 16:59:14.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB6524
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Chuck Lever III <chuck.lever@oracle.com>
>=20
> > On Jan 31, 2023, at 9:42 AM, Andrew J. Romero <romero@fnal.gov> wrote:
> >
> > In a large campus environment, usage of the relevant memory pool will e=
ventually get so
> > high that a server-side reboot will be needed.
>=20
> The above is sticking with me a bit.
>=20
> Rebooting the server should force clients to re-establish state.
>=20
> Are they not re-establishing open file state for users whose
> ticket has expired?


> I would think each client would re-establish
> state for those open files anyway, and the server would be in the
> same overcommitted state it was in before it rebooted.


When the number of opens gets close to the limit which would result in
a disruptive  NFSv4 service interruption ( currently 128K open files is the=
 limit),
I do the reboot ( actually I transfer the affected NFS serving resource
from one NAS cluster-node to the other NAS cluster node ... this based on e=
xperience
is like a 99.9% "non-disruptive reboot" of the affected NFS serving resourc=
e )

Before the resource transfer there will be ~126K open files=20
( from the NAS perspective )
0.1 seconds after the resource transfer there will be
close to zero files open. Within a few seconds there will
be ~2000 and within a few minutes there will be ~2100.
During the rest of the day I only see a slow rise in the average number
of opens to maybe 2200. ( my take is ~2100 files were "active opens" before=
 and after
  the resource transfer ,  the rest of the 126K opens were zombies
that the clients were no longer using ).  In 4-6 months
the number of opens from the NAS perspective will slowly
creep back up to the limit.



>=20
> We might not have an accurate root cause analysis yet, or I could
> be missing something.
>=20
> --
> Chuck Lever
>=20
>=20

