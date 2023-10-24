Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51527D46DD
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJXFUK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJXFUJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 01:20:09 -0400
Received: from mx2.km.kongsberg.com (mx2.km.kongsberg.com [157.237.3.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04ABE5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Oct 2023 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=kd.kongsberg.com; s=s1;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QqegAYCQlZCo+WYt0TyGyZJsYrJtqRZWdvSlKZLfk+c=;
  b=McjDymNCdttvkYpnrmROcpR9Hi9re1JLco6F2r+QHn5kYCOK30RuwVy3
   HFsvmpQH0xOh+kGKPRTxx0/2fZNRsfg9ZiRxEhjEbBwZ5IbsE3Vob/lmm
   Oe/FCd8E0LWvGKlub2fwT9kt3hKt2sUwYJ5D+FnKudix9bI9lXYjhoaDz
   g=;
X-CSE-ConnectionGUID: nSbEbfSTTdKtJofW0y+4uw==
X-CSE-MsgGUID: SvB81/wTQmucc1Istb9GjQ==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:HGkIHK6mpTz8ysVS2W73uAxRtGvGchMFZxGqfqrLsTDasY5as4F+v
 mUaXW2PPfjfNGD1LYhzb4u290kEvpGAzYI1SVBv/CkxEysa+MHIO4+Ufxz6V8+wwmwvb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ84nWGOKkYALjEnkpFVA+IMsZoUs+3bZ/2sgx2YTR7zql4
 bvau9fYNEKuxwl6O2cV77PrgB50tZweghtB1rAFTa4N5AS2e0U9VspFfvjpdSCgGOG4I8bhL
 wr95ODglo/m10d1Yj+Vuu6TWlEHRLfUIT+PhhJ+M0R1qkEfzsCa+v9T2Ms0MS+7uR3Q9zxC4
 IwlWaiLdOscFvakdNI1DkMESXEuZcWqz5ecSZS3mZT7I0Qr6BIAyd02ZK09FdVwFuqanQiiX
 BHXQdwARknrug64/F60Yu9XjOkpIvLXAI88plNnww6BHLV6XI+WFs0m5fcAtNsxrsVHHPKYZ
 M9faj1pYw/KbgdAfFwQDfrSns/x3j+hL3sB+RTM+MLb4ECKpOB1+LXpMdPOPNqDXsFImEqwp
 W6A/GP/DQoQOcaQjzGC9xpAg8eRw3KiCNhIS9VU8NZRnnfDnysMNCQTSFCw+NiilkTvdNBmf
 hl8Fi0G6PJaGFaQZt38WQCo5XiKpTYCVNdKVe438geAzuzT+QnxO4QfZmcZLoJ68pZnA2V3v
 rOUo+7U6fVUmOX9YRqgGn289Fte5QB9wbc+WBI5
IronPort-HdrOrdr: A9a23:5rbyDqv/n129L2nwvGhgEGjF7skCYYAji2hC6mlwRA09TyXGra
 6TdaUguiMc1gx8ZJh5o6H7BEDyewKgyXcV2/hdAV7GZmPbUQSTXedfBOfZsl7d8mjFh5VgPM
 RbAuRD4b/LfCFHZK/BiWHSfrdB/DDEytHRuQ609QYJcegeUdAG0+4PMHf+LqQZfnglObMJUL
 6nouZXrTupfnoaKu6hAGMeYuTFr9rX0Lr7fB8vHXccmUezpALtzIS/PwmT3x8YXT8K66wl63
 L5nwvw4bjmm+2nyyXby3TY4/1t6ZrcI5p4dYyxY/ouW3fRYzWTFcFcsnq5zXQISdSUmRUXeR
 /30lAd1opImjXslyqO0GfQMkHboUkTAjnZuBClqEqmmNf+Qj0iDcpHmMZ2Tjv1gnBQ5O1U4e
 ZzxGSeuINQDRTc2ALHx/aNeS1LuyOP0CMfech6tQ0EbWLbUs4LkWQSkXklbqsoDWb07psqH/
 JpC9yZ7PFKcUmCZ3ScpWV3xsewN05DVitub3JyzPB96QIm1UxR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY/vY1a9Cy7kISaXOxDqBasHM3XCp9r+56g0/vijfNgNwIEpkJ
 rMXVtEvSo5el7oC8eJwJpXmyq9C1mVTHDo0IVT9pJ5srrzSP7iNjCCUkknl4+6r/AWEqTgKo
 GO0Lk/OY6TEYIvI/c84yTuH51JbXUOWswcvdg2H0iOqtnGJ4njtunRdueWP7zwDDYiVGvwDn
 wfGCHpIs9N9FqmVxbD8W3ssl/WCz7CFMhLYdjnFsAoufswCrE=
X-Talos-CUID: =?us-ascii?q?9a23=3AOym79mndjRVzml6Ebda3GDPsTavXOXvmxlraLXS?=
 =?us-ascii?q?ENWpKVJ+SR2DI6eA4jtU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Apgng3w+PKtDTBiD4a0+49EyQf/x2yfT3T18xqJA?=
 =?us-ascii?q?bsMLdFDdsMWayjg3iFw=3D=3D?=
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="66918227"
X-IronPort-AV: E=Sophos;i="6.03,246,1694728800"; 
   d="scan'208";a="66918227"
Received: from unknown (HELO mail.km.kongsberg.com) ([10.64.19.15])
  by mx2.kdmz.ext with ESMTP; 24 Oct 2023 07:20:03 +0200
Received: from exchmbnodat15.kongsberg.master.int (157.237.134.10) by
 exchcanodat05.kongsberg.master.int (10.64.19.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 24 Oct 2023 07:20:02 +0200
Received: from exchcanodat06.kongsberg.master.int (10.64.19.16) by
 exchmbnodat15.kongsberg.master.int (157.237.134.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 24 Oct 2023 07:20:02 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (157.237.3.11) by
 exchcanodat06.kongsberg.master.int (10.64.19.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Tue, 24 Oct 2023 07:20:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3zOyJEd5ygN7SzSZ25xK2dGZkeyZjGCSORSAfXuHSxU1uPUvP6WajfdbSNcpQl7TDff1t1J7jLiREGJAwxcjqFpz5fcGGPYsNZNviyHM4eLAGvmOdTClh6m9FeDSGg5oUHlkit/vUlt1Li0jljuqgFfca5yzWxG9tsokVaRrO6vybLRWC4KCMA/Bhf2g8F7UrTbHWwEj5OXO7+J49yZZG/qbw6wCxr4apRq2Sfi+4jl7KvXJ0Fl9PDPEXwbl0K/7icXFP7HnaDvjxdOh7D/w7+gGsAKAODqBiNdSHvynDybwlgxI1CorlZ6wGC+qDaip2tLwVMHcfav7qVGC+MLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqegAYCQlZCo+WYt0TyGyZJsYrJtqRZWdvSlKZLfk+c=;
 b=e8toJH45utxd8iKs1R824ndnR0G95jG7PCOYC3q3AiMD38ZD1shz2yfX8nTWs30g4qZsZzfORs5Ax3AlpgW1+60nA5dwSgseJmvaMdoxgrk5Pjy98G17fQ/IgzV24Gdg0pclOZkMQW+qrp8s+tZfrZRZamHChkr+pY+G6Cs03GfBw1Kc94xjEu1SX7f11rRMjWmA4oAOs47esA6SJK/MC/+A0KAP6tFrSKjKw4cqv/iFtZCgZQUvaayJXu9nJKS+/1J/Ji/kMdp9BtiBQIQa6nM2zZg5rZQ6UrbVwK2jp5MkhsKYrRu2dGkC/lrjSTMRhUMSIr+DiY9AGFszOuRmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kd.kongsberg.com; dmarc=pass action=none
 header.from=kd.kongsberg.com; dkim=pass header.d=kd.kongsberg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=masterx.onmicrosoft.com; s=selector2-masterx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqegAYCQlZCo+WYt0TyGyZJsYrJtqRZWdvSlKZLfk+c=;
 b=vKILU04S5/sr/93oir91qwSp3ay9SAfkwM0VDZfkAXi0YWO89rKauK+aGv0Yyk7+F6AFSTAfa/DsYjIhrFWfRFAv6actOEfcAdYXMFXNa+5SEvMAOW1djM7iBVvQCxEkYPDX/3mMlEAn7+WOJQLVcJVllBEpePyJwMPh53VhL6M=
Received: from PRAP190MB1833.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:293::19)
 by PA4P190MB1055.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 05:20:00 +0000
Received: from PRAP190MB1833.EURP190.PROD.OUTLOOK.COM
 ([fe80::a96b:b313:2615:56bb]) by PRAP190MB1833.EURP190.PROD.OUTLOOK.COM
 ([fe80::a96b:b313:2615:56bb%5]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 05:20:00 +0000
From:   =?iso-8859-1?Q?Elias_N=E4slund?= <elias.naslund@kd.kongsberg.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Writing to NFS interfere with other threads in the same process
Thread-Topic: Writing to NFS interfere with other threads in the same process
Thread-Index: AdoGOVCgubSGcAxgQwCohyJMt2ZIUA==
Date:   Tue, 24 Oct 2023 05:20:00 +0000
Message-ID: <PRAP190MB1833A3FAB75002DD5467B8ABCBDFA@PRAP190MB1833.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kd.kongsberg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP190MB1833:EE_|PA4P190MB1055:EE_
x-ms-office365-filtering-correlation-id: 84a8c348-b544-4c8d-57ca-08dbd450deeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWutpDtdEgZiUqtAnUbwrnWqRft8nRZW4I0/ymDVMQFtOw6CdGL01mXkhpBpxc9yL0RuI031uGCGjUwtaEScMmLeNwnE4w9OLrxSdyGDx9qpDwMw2NOV/HJyzqi+f7eWVH2pp8zAC2jJZm2TtPf4HOzoefbXUc/Jsc9oj0Y9jxnVD0oKnF7qXjLc/kzmef9v8CocwfGsEUqqCXu42q7kd5SW3tP16YU+WgnmvvZDBBbzMPxARUvX8KvEWmkYKRd9AnEUvnrVHlcWz2k4CQwG0VHTkkye0t8bAqMcLA3dyOgaTgLsrNHUqoZmOfsgaGrAeLt9R0rNYHSvbcaQfMMevpGodUL0l+HaTiAFBNGA2tP/jJ7r9/vaCuXOmUOLNyoo5fwf7FKXvctYkrNGM8OZuTcCEMnWNIE1aZAsW4qNqmq+0684TXkuLgcm/w5XQeGSguqxo3AIE69kHKAgmPIONVxEBIEbFMyQBKgfkqinkwqVEqRxKl6s5g0OByG8Vpni+Mly3Ps8ICmxxU8PjoObq8XLITYMDf29uThu563hgFRkwcM3ZSLDav3CyrEY4OP5e0+eApYtC+y/Q3FUqAC31WIk+o7VwEXdw9cGzC7D57Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP190MB1833.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(316002)(6916009)(66946007)(76116006)(66556008)(8676002)(8936002)(64756008)(66446008)(66476007)(966005)(38070700009)(52536014)(55016003)(71200400001)(5660300002)(7696005)(6506007)(86362001)(38100700002)(122000001)(33656002)(9686003)(26005)(2906002)(83380400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QFjn3/8nCnMHTqqOofYg9M65wSwb54eeMpwFQIabwlDhKDHkRKoqxUV7is?=
 =?iso-8859-1?Q?4RziexD0FkG/LqXjuqS+0xSivwI0iNt8DItaecGik57gzUygxTF6Wvtvy4?=
 =?iso-8859-1?Q?75nm9aL12m+VspYcIkRRKRi0BqGY32UYL9PB0mofqS057tNOwLgr+kaJQn?=
 =?iso-8859-1?Q?7W7BJEuNmTCjUF8HqaCpw10aUX0zrdae67Zk7CmNQO/3raZtLEEwOJ7+7B?=
 =?iso-8859-1?Q?QvfvpIJ8LxjMlmKe2M+OxRW2kNTe6QTimBefflOAAaXQcXkb/nXx1ngpu1?=
 =?iso-8859-1?Q?D8VwZMV5+GXgC0iXcLTdrqH0IulCwzGDLimbSZmuTs6PlSy85CqFZ0vPG1?=
 =?iso-8859-1?Q?JGBGEUr0zwkYsIZEyVJ/H4ZC1QmaJKpCHex2vRt52BQD1sglXGYUHjlEgi?=
 =?iso-8859-1?Q?39iGKNNsR/EYWsq+UTS3D7KkuZ8jeFLuKHmsju4PcK+S+sdu81g+4YjuzG?=
 =?iso-8859-1?Q?hN1DhbT6m3N106iZ9A+7oN0zzqJ7gR1S9mxgbEKmoPHzFeGfPJOHUU++So?=
 =?iso-8859-1?Q?BzAfgjyVNyLKp6utJ4euCsKSKkY3kwnQdXKbpGY15ujyMetmDPBoYsMAfX?=
 =?iso-8859-1?Q?LCzeAljMET/a42aBftt7PU6CwYElZKDD+XnTNNim48gpkGv5C92dI7Tofh?=
 =?iso-8859-1?Q?t+/CpFhEb7mFw5bF2L7Y3JM/MpPcC2It72iSHOtelbdullUNsZRURHS2RF?=
 =?iso-8859-1?Q?JP9DiJUC6nFwNqcBo7eroyBuqChXdTZOTdzAfabzqccwIBov8tOZ597zTY?=
 =?iso-8859-1?Q?/gvMpaL6yIBkZ/Z6Dd0InN8AhEdtPaGIoDzkDiLOpv/s39Qk99Y49C2wFC?=
 =?iso-8859-1?Q?ZbFNA8OwRikVe56Tvv62yosnyMuoVjnGt/yYYrj5ewTqGKw6Q5wjqhdPUx?=
 =?iso-8859-1?Q?y6eQtjrSeh7OHKOigpQ+ojYu0P/iBZzX10ktbIqYiXCUZaQkgcCPwpR0A+?=
 =?iso-8859-1?Q?9roZLe+6t9tshwn1rhpHjtcV1PeB4RgrXb0K9IBrAnXiz3D3CJAHWHvvkk?=
 =?iso-8859-1?Q?LETc0rzTSFPujRO0MCcPsdNRBIaNkOaV359n0nse0pcIfnZmpPbB/pUuKs?=
 =?iso-8859-1?Q?+uACCcj0j1LfLFjdaA9e662ILOJTFOOmRiUObmNacBGNiyA41w3sdKeBAk?=
 =?iso-8859-1?Q?a8U7gudVpqg4XwNsIO+w7iLONeDsu2EAyl4YA1c//7KvdQ6PmtSYmPpH0m?=
 =?iso-8859-1?Q?vfNk86yXW+khbiptEsv+I4zDW7qK5LrpqXexDt4RRGIvaGToqcs5huPyI7?=
 =?iso-8859-1?Q?x0HvWCeroXvCfQc1V2lWCJAWVVOW4XOuofUvi7CYfY/Jw0ge6dTVeWUQCB?=
 =?iso-8859-1?Q?Gu6SGylwS1JxctC0/jGocMaSLwEj025LphlwyxAN7mjE7TteYhEgOB6sjV?=
 =?iso-8859-1?Q?kHAA35rmRTuOkYBDOelJhb0tzGSAqH7KbxksZzne5BsP4klBzmFUaEP8bV?=
 =?iso-8859-1?Q?3k5ZtZWq9rt5VkzYM2CImfK93l5HwghTVMLvIXd98gDJtRjzi8B6VIV5YO?=
 =?iso-8859-1?Q?QSeuEDnx5zde7H0km3eh/ilCVDUT8kzfCMOGXUTjHqj0rrvdWLVWozToNf?=
 =?iso-8859-1?Q?hpa4hVVexb8IgbALql4iCGtYY6r6ZXONthoxx42MoYLqYB0LlRNheipJp/?=
 =?iso-8859-1?Q?olkcqdAUV0fp1scSVGql+CpdHseuJkAOjkTWPPk/9hoRjtf1cQmBSHgw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP190MB1833.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8c348-b544-4c8d-57ca-08dbd450deeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 05:20:00.5245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a113bc9e-1024-489c-902e-5ac8b5fd41ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ptEtlW2sgOM+M5eCP5BEuJR6f/67H2UvRP/eaiNvCOqO+SN0vO5PknuudUskuWVQ3jCGYnDVa4XSV28Y3fLL+fqkeI2DB4QGI+12paWYHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In an embedded application we're running a Yocto based linux distrubution w=
ith RT patches. One thread is writing data to a file on a NFS and another t=
hread is once every second running chronyc tracking with popen.
The hardware is a dual core ARM with 1 gb of memory.

The problem is that chronyc tracking doesn't return within 100 ms if both t=
hreads runs in the same application. If, however, each thread runs in its o=
wn process it works as expected. It takes normally 10-20ms for chronyc trac=
king to return.

Tested without the RT patches with the same behavior.
Tested 4.x, 5.x and 6.x kernel with the same behavior.
Writing to a sd card works as expected.
Writing to sshfs filesystem works as expected.
Tested RT prio 70 (chrt 70 timeout 0.1 chronyc tracking) without improvemen=
t.

Full source code of test application is available at https://github.com/eli=
asnaslund/files/blob/master/nfs-chronyc-interfere/main.cpp

void tracking()
{
	while (!done)
	{
		auto res =3D command("timeout 0.1 chronyc tracking");
		std::cout << "chrony " << res << "\n";

		std::this_thread::sleep_for(std::chrono::seconds(1));
	}
}

void write_file()
{
	while (!done)
	{
		std::ofstream file;
		file.open(path);

		for (int i =3D 0; i < 100000; i++)
			file << "lmno..."
		file.close();
	}
}

std::thread t1(tracking);
std::thread t2(write_file);
std::this_thread::sleep_for(std::chrono::minutes(2));
done =3D true;
t1.join();
t2.join();


Perf shows (full log at https://github.com/eliasnaslund/files/blob/master/n=
fs-chronyc-interfere/perf-nfs.txt):
chronyc  4123/4123  [001]  2057.379201:          1     sched:sched_switch: =
prev_comm=3Dchronyc prev_pid=3D4123 prev_prio=3D120 prev_state=3DR+ =3D=3D>=
 next_comm=3Drcu_preempt next_pid=3D15 next_prio=3D98
    c0b5783c __schedule ([kernel.kallsyms])
    c0b5783c __schedule ([kernel.kallsyms])
    c0b57fb8 preempt_schedule_irq ([kernel.kallsyms])
    c0100c0c svc_preempt ([kernel.kallsyms])
    c04163f0 nfs_page_clear_headlock ([kernel.kallsyms])
    c04167e0 __nfs_pageio_add_request ([kernel.kallsyms])
    c0417300 nfs_pageio_add_request ([kernel.kallsyms])
    c041b664 nfs_page_async_flush ([kernel.kallsyms])
    c041b9d0 nfs_writepages_callback ([kernel.kallsyms])
    c026b88c write_cache_pages ([kernel.kallsyms])
    c041bb28 nfs_writepages ([kernel.kallsyms])
    c026de78 do_writepages ([kernel.kallsyms])
    c025fd8c filemap_fdatawrite_wbc ([kernel.kallsyms])
    c02604bc filemap_write_and_wait_range ([kernel.kallsyms])
    c041c484 nfs_wb_all ([kernel.kallsyms])
    c040c9b4 nfs_file_flush ([kernel.kallsyms])
    c02e08b4 filp_close ([kernel.kallsyms])
    c0309014 put_files_struct ([kernel.kallsyms])
    c012b2f8 do_exit ([kernel.kallsyms])
    c012bb1c do_group_exit ([kernel.kallsyms])
    c012bb80 __wake_up_parent ([kernel.kallsyms])

In the perf log a separate process is also shown as chronyc2 (symlink to ch=
ronyc) that executes in another thread:
while true; do chronyc2 tracking >/dev/null; done

It can be seen that several chronyc2 successfully runs before chronyc times=
 out.
E.g:
Line  7603: chronyc   3950  start
Line 10936: chronyc2  3978  start
Line 21568: chronyc2  3978  stop
Line 23820: chronyc2  3979  start
Line 24908: chronyc2  3979  stop
Line 25990: chronyc2  3980  start
Line 27601: chronyc2  3980  stop
Line 28305: chronyc2  3981  start
...
Line 129550: chronyc  3950  stop


Strace is also available at https://github.com/eliasnaslund/files/blob/mast=
er/nfs-chronyc-interfere/stracelog.log.
