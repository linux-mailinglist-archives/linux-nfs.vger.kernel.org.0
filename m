Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0758D1FA
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 04:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiHICRM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiHICRK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 22:17:10 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 19:17:08 PDT
Received: from wmauth4.doit.wisc.edu (wmauth4.doit.wisc.edu [144.92.197.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6361D0FF
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 19:17:08 -0700 (PDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by smtpauth4.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 8.1.0.16.20220118 64bit (built Jan 18
 2022)) with ESMTPS id <0RGB03SGLQ8HSH30@smtpauth4.wiscmail.wisc.edu> for
 linux-nfs@vger.kernel.org; Mon, 08 Aug 2022 20:17:06 -0500 (CDT)
X-Wisc-Env-From-B64: ZGZvcnJlc3RAd2lzYy5lZHU=
X-Spam-PmxInfo: Server=avs-4, Version=6.4.9.2830568,
 Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2022.8.9.10918,
 AntiVirus-Engine: 5.92.0, AntiVirus-Data: 2022.8.8.5920001,
 SenderIP=[104.47.73.169]
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKY/IPG04FY2CRXWhukAkaOxeabfU73mPxC+Jr/cjrHPmH4zx9hD/fVghG/fGltY6OQ5t5AZTUhMVM7jNL8w0NR3GlAYu6MwuFLv+bp7sAJcTHxylj3anJvkx2U1FXOzyUjrDph6JeS3AieZNeyJpcjGuVb5DsDkHf+9Xy9k6RVSSEDzjzwPBXD6NSX2rxJPur1NxLApBK48YVrwloydfKH+q2KZ+JNVxUXt+tEMNL84qnL78b7xPftIxeoBwHIiVGz8VS7cM8HISzbLnAZJ0t2vmhdFL5QNEdvU31nDvnCgqhOrfu4xazxz3fSD+eOx+VNpOi+vW3yMfs9wEqCL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqP9ALIm8UkC7CQz89z3xmdDQPU8QWunNTBWXTVgQQk=;
 b=XyJKJFI7O3OH38b3ssNO1rdHPGOjzjr5+uTkXUCEYCzk3ZoJ1rIPayg4PrEoaYW8rzUoKMo6VHLrUPy8lajhljQab3a++3L8VtjyroGzrAAunHE1MT3w2Mj2gjuACoqU5kHNF4vtatq+gc36+8fy0vfDQbqPrdT4e3x5C0avtFfUls99zR8cJrDPZBu5gB5u0wFikTXPjeXMU0enG9sEB0745a+eKMapaVkuvu3AJIK2CnApwkXTG7S3E+ze1qPu3pmblEIIFW9YjdoaFZAGspoSm2GXewpvEYlM3fbO5Tyva98Oytb8i6weLf63X/Ice366z9suvbdDteqtDCFerg==
ARC-Authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wisc.edu; dmarc=pass action=none header.from=wisc.edu; dkim=pass
 header.d=wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqP9ALIm8UkC7CQz89z3xmdDQPU8QWunNTBWXTVgQQk=;
 b=a6SduggAKmZgby5zKMcH2Nvw6FiNz4qw/IWfDHcRNdh80DSFIlfMZZIM8Cak7VdtKeO3odalUUHiAPubwbJkBcyQX8XRyx7elMb8gsS5dZAYC/0f38U4O4yhBe7iIL0YHl41caosDpxxPxAWMomPp69LttM6seWisa/lraEYBi8=
Received: from SN7PR06MB7166.namprd06.prod.outlook.com (2603:10b6:806:103::6)
 by MN2PR06MB5759.namprd06.prod.outlook.com (2603:10b6:208:124::25)
 with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
 id 15.20.5504.14; Tue, 9 Aug 2022 01:17:04 +0000
Received: from SN7PR06MB7166.namprd06.prod.outlook.com
 ([fe80::b8a5:b556:5d52:ceb7]) by SN7PR06MB7166.namprd06.prod.outlook.com
 ([fe80::b8a5:b556:5d52:ceb7%5]) with mapi id 15.20.5504.020; Tue,
 9 Aug 2022 01:17:04 +0000
From:   DANIEL K FORREST <dforrest@wisc.edu>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Strange NFS file glob behavior
Thread-topic: Strange NFS file glob behavior
Thread-index: AQHYq428dDTNZxBbIk2YruyMT2DYiQ==
Date:   Tue, 9 Aug 2022 01:17:04 +0000
Message-id: <20220809011700.bdiikqngwmxp3abf@cosmos.ssec.wisc.edu>
Reply-to: DANIEL K FORREST <dforrest@wisc.edu>
Accept-Language: en-US
Content-language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-results: dkim=none (message not signed) header.d=none;dmarc=none
 action=none header.from=wisc.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f249d10a-af23-4e84-0f05-08da79a4de9a
x-ms-traffictypediagnostic: MN2PR06MB5759:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2WGQjXnMAWKQ+cxDs65/iC4Eoas/EycEdtIFy5du+9JowvjzSNYC/doJdWhbLv8Nfk5joMsHUzDmW8sh9lcBaox7D8eAxjDp2HomkpPJSA5vz5yG9fzzy6s0YcgK/n8YqAYRojXdYJwdKOscQVyWGFHpu/ilyZBZcVh2G92IO0t0lg06lYEUxvFiggR30b980VY+v2/Ab2KslLtqvy5ptaafsg4QKNPUxfNweTrnbw3RKcITVx6CsF74MjrQhjubJ8rWTZEShCKZOhW4YoAJ7VljamNZtETi2I/aq/XObLpUzd7pfBZw97FNRW1LC5m+pcn2fy3+Fp66I8WHOZt0T+KgIbdtGPKqdl3nP/2xGRmnDH4RLZFAI+ngv8WA8T6JBP8obT7lGBTScTBeBg4wjAO4/QL5GKLAJiP9S5fNBvMP2WfxJYSvw8ss9zZH0ObHONaW0XgldW4iVkIulDN+dDpCU1H1ZJgA4gAfZ2T+KfjZ8+ebrNfQxpNBA/GhA9MVr0YAuzfhJQJt/E8HmJDr6ke7zM78gJyQp34CW5PmloJ2ojwn5zv/LYcXTJ1W2zPhrQg0ZoEQBdCFR3jwVatfytNvI6CLoT/zEnlKqqfdpGvmv6XszmQHq2P88l0RQpk7iD82kZ8awfRUo/iYtbKnZeds7UWh9SjhUG3SdDBgV5t5NSxt3EPMl2LuT9m3VpAQGF/87VS53Pjl8FyV+5o/QWKIoCmPiUg0nGkGr0O+XRrYuQR6gheEe4lTPDMNeBbdncCbDr5fmkMTVnMHEabWa1ZWXxTRCjZOdvwwdishcBOdF2dIpgtMl9wRmHojoLo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR06MB7166.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(136003)(346002)(75432002)(38100700002)(2906002)(66476007)(3450700001)(66556008)(66946007)(64756008)(86362001)(66446008)(38070700005)(8676002)(76116006)(91956017)(6512007)(6506007)(26005)(6916009)(786003)(478600001)(316002)(6486002)(41300700001)(71200400001)(186003)(122000001)(1076003)(41320700001)(83380400001)(8936002)(40140700001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AxqH56p7zj0RrO7+ygVX5iGoDBLEJmPXV/Ike+iyLyoL9eHGa1m60skeN5uK?=
 =?us-ascii?Q?K8m2MwNDAcBQvweUxR1zbq6BrFam5dYWHWSRvQV1QqF2MUQWwkWPtxVthsew?=
 =?us-ascii?Q?jsoHrigYxJ0pejwzI4xXkmf2egNiGx5p/adm9Wh/PCMfGPyVeTLlQV6B5TYz?=
 =?us-ascii?Q?bnl6XiP/BLOFni9Pzvhz5Y7r4XG3DvLGpFIk2cCvpZu8YbqmiBo1tA7O8E2w?=
 =?us-ascii?Q?L5j5AuFvac588VJj5t7SXzIs/Lt4QUFN7tgGSdQqLM1qi02xRldMV0vY0Z6y?=
 =?us-ascii?Q?OfiDy0PRC0NagIa+XtRcsxTh3V8tSAll1MxlNbsHEXGETdUD4poyzwWG1Vc1?=
 =?us-ascii?Q?hnWwxF8J170xpol7LgvVL0gNxutmQH0EdjKIcAH/q68iTtqwT4DvmvZLLS4+?=
 =?us-ascii?Q?3KcH7W91Q4wZ5oobdvZcwB0iUOJpZEceMTZZ3PwdItrJOZhpA11yUkMtEP2H?=
 =?us-ascii?Q?HZTGOecYKKJYNZ1Zldux3OKkPKd0QMSbL4nXa2JrErJ7dLAplkkCHjBNQUk7?=
 =?us-ascii?Q?78I9vfFDz27LUwsdUl9BqQwdlArIhPN+E+fpYJvAv/38syMqFQdCrNJm1dhD?=
 =?us-ascii?Q?4c+IYJxM9lxE4gem/ByGbP7G1f4Fng4rJUYGI/sYdHuX6vyHQxGNkHoHrocx?=
 =?us-ascii?Q?yaCJQeEpK3miT3n5l1jyYN9MfhNanx327hFirjTNQWCNZWdELX9WQCzkJ+RB?=
 =?us-ascii?Q?3QTXGJWU3OEtPPu3PuCYihXWAjds/eBYTkaroClU88dxEb+x50h0TE8Wo+kV?=
 =?us-ascii?Q?Dh2uEAHkNcT4FCwm8Bt5oAeJUGF2makkQMzQgBbcILUdrkcofbpFqmaXwYmu?=
 =?us-ascii?Q?hzI4EMgkFVS5kjaVuYvC5abOjpzMquYng7I+e1qZiABVUi6cd+5PR+thuJ8D?=
 =?us-ascii?Q?6zEmfk++agdmxwDtqrmsgtF2lfh5p2vkQKY95m47h44VxZ/GwX+QhELeebNb?=
 =?us-ascii?Q?tVcNkiCKJOzLb7ITcN0mdk/P9ZVGKgGtdlhEf0pkJW+ScyFeGgPCm0XmQtjr?=
 =?us-ascii?Q?naFVu4R/VgLhxGazLnUOhr3pciuOkggpLcxU6EJ6qZ59zIVRS15O1tt3VNIN?=
 =?us-ascii?Q?+4wSyWLm/aCJ//K8245dtP6tyfrASUhOq01YwMf9NLq3J+zPbRRMHCQonaWT?=
 =?us-ascii?Q?/GehqbTNEsoLoOc9nmyPweE0tOkNkJJd4pUt8w47GuLxI5kv0e7d78Uuh1Sh?=
 =?us-ascii?Q?9Q2iob6LOZrLBKVONpxGdArfu/HoWWBgOqzoWYBmDjZaka6tMZ4a+eofQFcO?=
 =?us-ascii?Q?MaX8o4k7Lm2N7In7svJ34USmalijXVkuxmMtT/Ac2sbnr0WURzhSAFONQMzZ?=
 =?us-ascii?Q?KDK5ZHrWgxecm/zJsy74DHi5cIog0l71QSCsvsMRBKjxoa3KpzbhTm4x13bl?=
 =?us-ascii?Q?frbIvPpverr+2FC2K90hbfhyav7EsniRFODofNcjnN9fHJmSG62JTHgamjne?=
 =?us-ascii?Q?q5t5psLiJYyfYlaPl+eZZmd1AtbFrKP6/GRE/OWHlUQIUobkY6hmiH4Z0BCv?=
 =?us-ascii?Q?MNkKpfTUiSRbQogLf4pqA3qrLoyAI1dpO2euP3wgWzFIQAgJm7M5lgVJgB3y?=
 =?us-ascii?Q?7JP+15kvwPwKz7j4z7fq7rztK1rsd2Z5giNnCC0ZYbgkdSOkKBnZgV3udNUR?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-type: text/plain; charset="us-ascii"
Content-id: <33461D355A88C3419F16B84CCB3F03C1@namprd06.prod.outlook.com>
Content-transfer-encoding: quoted-printable
MIME-version: 1.0
X-OriginatorOrg: wisc.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR06MB7166.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f249d10a-af23-4e84-0f05-08da79a4de9a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 01:17:04.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knYN1yac2CxJ/mAO9wvnvHXm3Ya/JeTSxjvvqMSBq3JQxhuv6FJAD7UNh1Tj15SthJRVIuTXD5t5lIWs2QY2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB5759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I am seeing a strange glob behavior on NFS that I can't explain.

The server has 16 files, foo/bar{01..16}.

There are other files in foo/, and there are many other processes on
the client accessing files in the directory, but the mount is readonly
so the only create/delete activity is on the server, and it's all
rsync, so create file and rename file, but no file deletions.


When the 16th file is created (random order) processing is triggered
by a message from a different host that is running the rsyncs.

On the client, I run this command:

$ stat -c'%z %n' foo/bar{01..16}

And I see all 16 files.

However, if I immediately follow that command with:

$ stat -c'%z %n' foo/bar*

On rare occasions I see fewer than 16 files.

The missing files are the ones most recently created, they can be seen
by stat when explicitly enumerated, but the shell glob does not see
all of the files.  This test is for verifying a problem with a program
that is also sometimes not seeing files using readdir/glob.


How can all 16 files be seen by stat, but not by readdir/glob?


OS is CentOS 7.9.2009, 3.10.0-1127.19.1.el7.x86_64
NFS mount is version 3, readonly, nordirplus, lookupcache=3Dpos


--=20
Daniel K. Forrest		Space Science and
dforrest@wisc.edu		Engineering Center
(608) 890 - 0558		University of Wisconsin, Madison=
