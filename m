Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51636682F80
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAaOmX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 09:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaOmW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 09:42:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DC46154
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 06:42:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5QBzki69AhSMehDadMaPfY6mmwvWlWfoU3gVI7+jRavMiwwVJFHv7QI0YJESkDWTF1l06OLfFk7J0ZjsJo4+kRJkn2PdECF1aLoh/KQtrfUr2idd58GXTFTLlTDIctYrobvG1ccyqA+hxVbAn9s79eCByllTMQxUpWR0aiYYFd9StZQzZMuWlnrj0AyPsg/46ppPtUPxIbVIVL5tdyTML20rIKcjJei2adtZ9WaPR/lzUrflije6uBHVlDPaVVDDvDoOHZuYSoeZrbQ6u6RGCYX3IPD369bpN52Vw9T1TYZZ3z3e2iXMUU6Y2LcdwDqCYCN8uR/XHhgdNY22qtlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48oPfSrRuM6igBPv+KiLrYq9DjqBG268xbhh7f8S+SY=;
 b=L5W3Oi9dEwIH9lbiClqSlu+6Tbq9qKCAnh9KyYb82X7R38Fmt+LJe059zX7z1gwCx24FkfpnIBGCEgNYDJNDXL/J6GLAgzUqaRE9lLKJAddJxcxA8x0POxVZ8kRJe+GU8ASvFRQyvkcw/l8fo0Q1nulUMR2VgTVi2rIYsuku4HRKwDxtBFnBX4+IWhuskKtliK53+J35cENCEKieNwVcWCbGL4L61r6CUBoQmtDF1phiSKIJtj+qiq8LGwUYCe6pD3FTgUBDs151lFGZHbqW7v6noLGAANYv8lJUzw8d3RpFm2gcDYv8U/OZNNLTapfmXz540X0gQF1LALwMc0fjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48oPfSrRuM6igBPv+KiLrYq9DjqBG268xbhh7f8S+SY=;
 b=X+xIjr7nD7O7rjiAuytpN5F3UmfEjsJEEyM1Tzad/iOJEhAC05dkVTTEie5vssCizGmFAwvW+4kLj/YscBpH10izQP2sanUkWAOHvhqBziJqh8OwqTCPBmYlxgAkC9eS1cGY4bHD4CNDDU3YYP5Llk/vGqfXT2gLC/f48o3X90KTlKHLX3msWMUU68Gm1RUNBMJ1FS2xK+Z2HIMpMcL0JNbo6TYO6rsCGMXLU8D32G8xQzvvz1MvMDT6GmoN9hGhzrUD4u8MG7tCu04be05nHqadVg1q1f+5gfJtcCIZJDVNIzFFtYO3/s+MOedQ6dR+8zM+oE9ne+A8A0BGsIezPg==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by DM8PR09MB6280.namprd09.prod.outlook.com (2603:10b6:5:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 14:42:18 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:42:18 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64haaAgAATyXA=
Date:   Tue, 31 Jan 2023 14:42:18 +0000
Message-ID: <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
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
In-Reply-To: <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|DM8PR09MB6280:EE_
x-ms-office365-filtering-correlation-id: 105aa748-79f0-41de-2543-08db03995a9c
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7oELvJi2i7nCXp2IYTlEdinfznirXrNhRFOUtHZ8mWYaFDzoIC9t/o0sLPTYldfOubwYWbbbNbm3OJv7/jklgjId1lLlup9mIVoff0qn1iqTKJAkU1dtbgXn9WlVfArhewnoiH3uVaFFDLMmWgdA7Z5zJjenbYZlIJG8kyv7avqAruu+Es82vEDTJ5WxSPBdtC5ZtobBREqVvh9tlTmsN8LTHk1ypTLD6oRzTQgrFqHwNxok+tYSl8cBBmEcXsapY0IikkQC3gRBhtHmjf/8vE6x4e4kkMeGhPJcDihk29+7/TkobW8o8IjBYbp6YaI39CfOfRvkf8dqBTDXGwnJGlG+MOU0F/F5fBbLNduQ0fpKS52LDchdcNVwvX00LU5XntdRB9Jw5R9hfIGEQN7i2bN6GAw9i8EfaoO1wsIzEVmvJG9ldHAlu/1Lagnn4gOQCFHK0rffLTqU61Rdv7XHfdbUaecDV7g7+BVkm9ICODWNPq7XuuviuJPUAGP3kffQNdPm8HZ3rdpKMqUUk2Llc3ApAcIOWbTOpK2Idhp8+oyIVdvLtJ/bGsZ5VNlQU+p4qwQeg8R2WRt624/qAf9+wPkamBfZbqGNbbifmrIkuYX9auTZfUE546Eu29ac0tHBQ7lu3tNdpeQK2KyU/JdUolNYG6CqN5h4vvJHdNQmkVOqviNU9LiCxQB81kjylaExB0Fcjr89kNeagPIOvaLJLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(82960400001)(52536014)(508600001)(86362001)(110136005)(38070700005)(5660300002)(6506007)(186003)(9686003)(26005)(122000001)(2906002)(38100700002)(83380400001)(66556008)(66476007)(64756008)(66446008)(71200400001)(7696005)(8676002)(55016003)(8936002)(76116006)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d6AJkLgMcvDJv3aZ7qti1fQ1GM7edOC5n/Ssc2zXA1kDUSrx9P71EiQcUVrQ?=
 =?us-ascii?Q?9+n5cx+UfX2K1dD0xC3P9w69oQjdxudH2j6fqjmAdlxYa7QNftrnNYgBW/Ep?=
 =?us-ascii?Q?q9vnCEjRcLSswMTML+RarA6bwko+CasgDPVEvohaQZEiZaHU7r9n0v44XUQn?=
 =?us-ascii?Q?Xrwnkq/unMdW3RaMRikYS2P4I2oARIATu4SK4fZVEC814WPL7w+DtagRf0nC?=
 =?us-ascii?Q?zcG/gJcUWifLwNSkpz9mEoqJT7ata9eYGbfYlpu/mgW0w+UFZvunL7QNq6G8?=
 =?us-ascii?Q?rWj2e/ps5zbJcXxzL4ur9ljZfrcjWPkVer6E+6OKiSf7XyiGc0T0jz9PFfQU?=
 =?us-ascii?Q?gXzw5aJtWfs0LPEg5ijbV19tWZ/gxkSuwfcagFEjn45rCPO+NeFoF30y+j8L?=
 =?us-ascii?Q?jZOKtgzbh86kJ46UQpDLZ8SK6M9bFs/B6GH2QbOsT1XO1ZW4l1LRKdbMg4IS?=
 =?us-ascii?Q?prwyKUdyFv7EnpdlN5m0+PTd8P4IGZUK14MLtlNPn3Eou5hKsCAG3RMdp8FB?=
 =?us-ascii?Q?b/X1Mapy7XIQmWaJpRCOodT0rvlMaEqpBWr0VAoNkfoYiX3aeR8blJoNLgw1?=
 =?us-ascii?Q?vfrJwlsZnNjC2hcTOzTUY5qyqHDU4PfwhzTnN28ZQNdiaPrVxFMxJKRol/k6?=
 =?us-ascii?Q?PebT3s3ZrQ/ZIFCBqGR79uqa4Wa5DKnEZrZmxPSICdbUfWPPFvZAiRHGSKMe?=
 =?us-ascii?Q?15nsUNIDmV+919w/urtlC+JeEyLPwUPtT+wDeW2ME1EaShcOrmIhfhyULP39?=
 =?us-ascii?Q?sKBnWhrpk+WQBlIML+d3xo4talWl22y96TnqQf8aPto4sgrwLsqZqkyMKHBS?=
 =?us-ascii?Q?gRjmIeriHtjG/fUodtQ3QZUktolY5AcyCEnoKnZy9L4Qx+QoiAYpr2FF2u4R?=
 =?us-ascii?Q?sGvdwGwqGy8sP6+trgm0b/sNYtM85cK4lVtZBc3vq7UxfrV9LVRO4wPmfmH6?=
 =?us-ascii?Q?3uua3ob1I5/D22iWjE/zLfYhI6rYZqZyZr5UuNGwKV4+18LzPEWW9KqvhYVe?=
 =?us-ascii?Q?nupqdaqJVp2dYTWuzRNhdptZAK/EbrYGkanZ7xu4xp13LOQZ0BgngVggT4iC?=
 =?us-ascii?Q?bwLjsfPzwH1CmT0wKZvIArG47wbTcmU0862HqhYSjrvQukyrAHdn+yuSms9/?=
 =?us-ascii?Q?6plK0Xok8tUF9LP/4B/0dwzABonDdhUxuwhd5z6jNXbviVGI9maQtIRf7U2h?=
 =?us-ascii?Q?hPLWW01qJfKJl3TzUOr+KwChTqqWosvq2qhJatHkoBoET7jIK3uy7b5cl6xe?=
 =?us-ascii?Q?BU2X2W8WjXIFQIEhV24n9vzCs/vTlaxSoeKaQPWDlcec2NGFxycnYFFHkTYz?=
 =?us-ascii?Q?kqFOGcranef66EODSPDz1uW9e6ZvcCRy57MIYXlcsFBQF3ugZh7c9Cdh6+sr?=
 =?us-ascii?Q?dz0LJseaAbwlhlC13prRJd0Hj1yvOHifDrosJd3ULYH9W95pwcsPzBcxLXZE?=
 =?us-ascii?Q?/UpswBa74yLef3PeCFUlT5n2g7p+Jeo5ReAI8haV/YllHCCz8DKJ4dAGcobs?=
 =?us-ascii?Q?NEfxqBErU2apLD9xmMx8jWdPONn/Jw5k6TaJpVk6utNH5Jzh+7ONlGNJLBN0?=
 =?us-ascii?Q?wAO2lOyXKkN4ztAhnLMoiNNEopH7DiGi4cx1e8qp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105aa748-79f0-41de-2543-08db03995a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 14:42:18.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6280
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> From: Jeff Layton <jlayton@kernel.org>
=20
> What do you mean by "zombie / orphan" here? Do you mean files that have
> been sillyrenamed [1] to ".nfsXXXXXXX" ? Or are you simply talking about
> clients that are holding files open for a long time?

Hi Jeff

.... clients that are holding files open for a long time

Here's a complete summary:

On my NAS appliances , I noticed that average usage of the relevant memory =
pool
never went down. I suspected some sort of "leak" or "file-stuck-open" scena=
rio.

I hypothesized that if NFS-client to NFS-server communications were frequen=
tly disrupted,
this would explain the memory-pool behavior I was seeing.
I felt that Kerberos credential expiration was the most likely frequent dis=
ruptor.

I ran a simple python test script that (1) opened enough files that I could=
 see an obvious jump
in the relevant NAS memory pool metric, then (2) went to sleep for shorter =
than the
Kerberos ticket lifetime, then (3) exited without explicitly closing the fi=
les.
 The result:  After the script exited,  usage of the relevant server-side m=
emory pool decreased by
the expected amount.

Then I ran a simple python test script that (1) opened enough files that I =
could see an obvious jump
in the relevant NAS memory pool metric, then (2) went to sleep for longer t=
han the
Kerberos ticket lifetime, then (3) exited without explicitly closing the fi=
les.
 The result:  After the script exited,  usage of the relevant server-side m=
emory pool did not decrease.
( the files opened by the script were permanently "stuck open" ... depletin=
g the server-side pool resource)

In a large campus environment, usage of the relevant memory pool will event=
ually get so
high that a server-side reboot will be needed.

I'm working with my NAS vendor ( who is very helpful ); however, if the NFS=
 server and client specifications
don't specify an official way to handle this very real problem, there is no=
t much a NAS server vendor can safely / responsibly do.

If there currently is no formal/official way of handling this issue ( serve=
r-side pool exhaustion due to "disappearing" client )
is this a problem worth solving ( at a level lower than the application lev=
el )?

If client applications were all well behaved ( didn't leave files open for =
long periods of time ) we wouldn't have a significant issue.
Assuming applications aren't going to be well behaved, are there good gener=
al ways of solving this on either the client or server side ?

Thanks

Andy


