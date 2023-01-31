Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596F668356D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjAaSfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjAaSes (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 13:34:48 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D659757
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 10:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXZ2aFpi6dPIkewzd+EZA9iCWDULFSl7ELqiuMFZkAwWBoyOIxmVbPiyyjjg72wbODNIMqZD8llJGWwPmfaVo6shQ4UZUCpevg8hR+LqzDVNOGkhEEUzi/LG+e5XO9JJ/uDm5g6mCnnKelCsGl094NpR8BMHvXh8YbguuNEbnUIaAnqd/Cmxvv7aKKu9824zxfzw4J5Xmz4zICX9FuKR06xyBsta1qByWcQtLGuGqLva+tGssOT0/t9Z0e44+qrPHritA6nqzIXsFYL+nkIMMNlJ7ZyZwyrHoZaIwHQKaExWJQct7KFz3rBy1BLVupXMFU2ogIFEOge5zBFHzS6JDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGL6HK8Mjw3/AwdCVCK4W9SrRjhxR63qi/jNPfxUKWU=;
 b=OCtEEvxrVs1bzOFCxUIrZgeu8UiKJs+oVsaxkLJHNoHH4Q7kRs8I8FlgffP460a7MxVPjxSNMKFioLRZYnliLAhecekcYaCQqmX5/W+yZDsYLDeUJSRgFdkTLohqBBd9o6bi2k8yiY7tgk/weQPxv0e7Mhi/10UEkDWkDNTs5LlEThBPiGuZrunar/FqARpD0jge+Y6gpMD2ZdXXSB5/cmC5mIOcBdkUB810KPO92AGHgzt6xVD/PWPPUzbuAQaDbNJTFE6b7SJc+qVbw6HJnynSRwPmr2s+GokSzr7wEdaIG5qAYdUE03iWIP3N6QXe0EeZxcGUEBBXmllIiZ4PKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGL6HK8Mjw3/AwdCVCK4W9SrRjhxR63qi/jNPfxUKWU=;
 b=sslMs/CA+xKcZkOCIuFpiW/gBz/lXUOqwtSK3dgDkWOjesTA4IMVMYYDTxyFfSgHbe+/J7Nd2KpjlcekpXNHBmchSYFyNSCtsRtlIv5OGJ/FI/YbrzciaQ9m+8TCv4zTlnYenL36AdceULPbSef6DWNlWxRJwJxlQxXmhXWKSHPHI3viDXR4TcYMJA9kKdQKID0me6dTDihwy+sW2NDrhMnxh/rRB/X5Ne51tCR5xYMNgfrWClAGuPKvruwvUnNuzScAu5hlZCZB27G9AJ3VYhdbTMxW6Zk2bOaUirZ+3mMN+CgSf2PxtKtvFFkkoZmuHiAiNdJDh6KtlzyjTu/7BQ==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by PH8PR09MB9452.namprd09.prod.outlook.com (2603:10b6:510:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:33:26 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 18:33:26 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64haaAgAATyXCAACB5gIAAAJ1QgAAY44CAAAHUIA==
Date:   Tue, 31 Jan 2023 18:33:26 +0000
Message-ID: <SA1PR09MB7552B00147DBC9200BB8CDBAA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
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
 <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <25395E08-073E-4572-A46D-A2228DB0212E@oracle.com>
In-Reply-To: <25395E08-073E-4572-A46D-A2228DB0212E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|PH8PR09MB9452:EE_
x-ms-office365-filtering-correlation-id: 0670fb95-4c62-4b27-5b43-08db03b9a47e
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyQEhXnB8mcyuPhZ2rzVtrioAsvmloZBuTuet6QRpQvxPETVv1nSt6uML6AK6ca8gKqPdNPSttAJI8qhUxzKEoB35eWmlJfr0FC41LaMVRsbLRsV/areZLgnl2oUwlOnV+qZALj+/W+XDKgD4+cD/Rnj1ZbOGMzUp/t5tt4rmf5dIfv09fNGVTw+k61KaZJPUOkHsm5rZsDDt7AVW8TTNB5LVh9QMrMyyI0y9QB594/El+JZT8lqn5NNkSP5GKPqB6qU8TXmpEj6xERL/DOMOknuObFRpPU95CWL9OuWBq1px2ZX7gwhjq4nUpng+o+ldXZsHfs5AxioWAgBKxfaTQ6o9clhPFJtv/UQhuQJSzEAGyg0z6nW4RrhEYJpNLjup9LJWdpViAPGD0rKgBX/Zoh9QYfVlAuUXdsoqZNziWZ9zppKomb4JhqPzXOdJr7SY7DCLUjvY+/KKECYhTdSn4/vOCHpr2SYM9AfHcXVuYS92yMLxvwZGpSJIDXb/5QbhjhjB5RMlAoGVwqBcy7p6ip1I40ETxFvEF/jRIu/LitLOD4Gso+gWXFISOlcgSYqWsX/QKJCf6l+yncLf28xiJ9M4gGYXRjgmTPsi76DW6avJoFdiAyM5eogFKXcNLCzFrWWs2LSvV3gbFSkOa7cHtZ5o3AOznSfN0qeXku5kR1vN+ZVmA+R81POpLHd0p90Xv6SeCksTBu/6OTgMYEKYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(82960400001)(52536014)(508600001)(86362001)(54906003)(5660300002)(6506007)(9686003)(186003)(26005)(122000001)(38070700005)(2906002)(38100700002)(66556008)(6916009)(66476007)(64756008)(66446008)(83380400001)(71200400001)(7696005)(66946007)(8676002)(55016003)(8936002)(76116006)(4326008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kj3rXFNeZh1D0pH4pyVQ049J8D2BsUzQySTpkgFqRg14WwdzeIfwCsCYCD6O?=
 =?us-ascii?Q?DUWAa+1xiFqWwSOMbL++CuY0b0KJ5yQc9cuLXzd7PFJA+E6d4iQ3mEmkqSWW?=
 =?us-ascii?Q?IYnwisBTKHQ4ZL0U2i7c91x4YoQ+zXRYCbDvCKTjgkCJ45Ol0hgcpL5rf/iW?=
 =?us-ascii?Q?8GROIIUcfsHyoQ/fX25v8xFmfPmVvrhNhhQ1GAyPhtDg34CF+6uiJraO2iOa?=
 =?us-ascii?Q?WrY4gBKgsekPCOKQ/kA6+WjiJNKuK4E4iVcWLsolFZlSNetvCHFg4NhSwXJr?=
 =?us-ascii?Q?tc8jqBUpfsQt6NbCeQ/2RWYxCjFvvqM2CoJJsIN4mcWxxo0+rSkPa2iUuY3B?=
 =?us-ascii?Q?mnIJu2x5hxrw0nfGWXi1r85Ud2PnEE9GeILErRoe7gRJfxgiVHTERGZprz6K?=
 =?us-ascii?Q?texvDK7p1/nOcrl6rN3lMl+V1drWCcLMGg1JRE8EUAL3TOJMDQlofHjkW1AL?=
 =?us-ascii?Q?k9L5B/FXHLs7/xYNyuKVvs5NYDUYhhwtwXJCZOwTJJufe7YcS1RQzTxdMVJn?=
 =?us-ascii?Q?UXCfyA2jp080FxcezaZmWTaMNK5NqGTBGMBl/STK4d6reqw8YkJMcmtUTt61?=
 =?us-ascii?Q?FqJk9+168Y2hqemxWM9kqVl7KXoOILsfiWi+EGl9COUOTjMzxqQyrdCyaqx8?=
 =?us-ascii?Q?PtpKeAv+BFAqp1kl++u0d9dAyI+MWfanvoGlFuO2VrRbhhu/THAmMGZxL9hx?=
 =?us-ascii?Q?5flGVPAYZrB5ozflcsLL3LpiOBSpCJRlfE+wj54fJXvZ9wvICKLXRDBg9ze/?=
 =?us-ascii?Q?PWO2BXd2n+NfNdArpEFWnPGXmUq4iqyXlFr011a2aKqtdFQJHfBA11OGZcTY?=
 =?us-ascii?Q?v9MbFW4HC4Igc4iTCZHMTPEZ6CUUMENFfeUjMhIIZAq9rLNlNYrXgCh/m6Nw?=
 =?us-ascii?Q?sj8SyRsG5oHrDrrotE4XAJzXqQ3iGoUhi/1JQEiUfznq/dCsHT0+yiO+wlFb?=
 =?us-ascii?Q?ct3pmvl/aLejS7JGY75o6dEGr/HPRF81+cz/IGtKTGJlkZJcwfAer+hi33ab?=
 =?us-ascii?Q?oqa9abzoVK8N7L50Df7JnwvvVhwAK8lsH7/Nk5yuCxbb54qo8K07WGa0836A?=
 =?us-ascii?Q?rm+GbFiUP85oit/TSwrb9gGQ/wAIV5rWXFenKZ3wGDi8vZlv/gem3Ccjro8z?=
 =?us-ascii?Q?2l5ZFPBkl1dseDcuHq8/IlglozWpSf4pxKejLBOPOD7xl5ldUmSq6GVqQLpZ?=
 =?us-ascii?Q?riQTHTza3sHyWWvWbtFvVRcbd9gyUd6xKDYAD0u+VlmCieyFr3NPYaM6PFms?=
 =?us-ascii?Q?OHxpGZsQNaIqU7tu7F8vQKCaSeVIKnly7CifpOqGRvXsNAVXG0zHloC+4O9M?=
 =?us-ascii?Q?ewneb4ZaHMp6Ep5N3MIrsDX4IyixSwWnk+WgD9icrdYYbjXCkqV1Yk+TCxYF?=
 =?us-ascii?Q?levF4UBO8ikfXm2NAIFHPKdIaOaBrYmS5QmP8HnFSmQ6Yip+LwmYOqZ7KrG+?=
 =?us-ascii?Q?QeTJ0ErwVhg6QhTrP7pWxuvxa9qqqdN76LKaDrp2vNdiFaWEgRya3PmasbCp?=
 =?us-ascii?Q?WzmRuSEVeZxdkTc9JIhafNCTxRqinUo1/MgVpxT7ugLVb2KJkDs0W8YA8aMH?=
 =?us-ascii?Q?CPq/pCQak9NtmMT4U5cLa6okpg6rhFi41tkDm2Q9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0670fb95-4c62-4b27-5b43-08db03b9a47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 18:33:26.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR09MB9452
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



>=20
> That's not the way state recovery works. Clients will reopen only
> the files that are still in use. If the clients don't open the
> "zombie" files again, then I'm fairly certain the applications
> have already closed those files.

Hi

In the case of my test script , I know that the files were not
closed explicitly or on script termination. ( script terminated
without credentials ) .   By the time my session re-acquired credentials
( intentionally after process termination) , the process was already termin=
ated
and nothing, on the client, would ever attempt to clean-up the
server-side "zombie open files"

The server-side pool usage caused by my intentionally
bad test script was not freed up until I did the cluster resource migration=
.

Question:
When a simple app (for example a python script ) on the NFS client=20
simply opens a text file,  is a lease automatically, behind the scenes,=20
created on the server. If so, is the server responsible for doing this:
If the lease isn't renewed every N minutes, close the file.

By "simply opens" a text file, I mean that:   the script contains no
code to request or in any way explicitly use locks



Thanks


