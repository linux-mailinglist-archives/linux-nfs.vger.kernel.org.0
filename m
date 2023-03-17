Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5917D6BF1AC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCQT3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQT3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 15:29:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A7B4DE28
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 12:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb1yfyqumajvMkLFx5xqvXfuGYvY3CyzTsKW3UIFcEPjDixwbX9FnB3tdCActZnvxAYrAxNjuoiFyFda3JmQajX/3h7MB4RBiYhNPvNHOPq6nKjHWcoY0ch31BHj3yGkZ9FQ61ho0BnpoZp01Uj1foHSGqkIp9A/edHD+GcPrFGXp6yXlSkEprjQhj4OtO+RBOKhEzwVxO+WjNlhxbxzQouDnhmy5QXLnBR29ruLDIRRAv8YrZjYKJ/H5aqyl7rimrt0ee4a/3G5ksPEgJSlmDr1ZrhO0pbHkEi9ZYYwKyEp7qxO6DLJftDLYbuGFPtjO+Gui9jrVZsLLZFtkXDOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHFD7XvAR8Cxx1te5sDZg+E93wQ3hMNSR4btW6dOqXw=;
 b=GAKK8bV+vVHUzp7ClP0NkfVeywBM5hgbM4g+zeS/9OkItwA0LFWW1VmAFoBD8gml9fqA5i8PeriPFOqAZIxWhbyAj1L++XhEZe3F9oEWo0JahczgN6aBXljgl0AfwneIHwSTem9WIUG8fPZ8Yztw4jJHIP9V5H8CeEaKTjc9i4ELxF0woiTcKlHSxNjsLA2dZX6ZZ76UD0NuhUVioO+lMi+KXYMDbmBUxS1mqqnEif7XTgH+xBJ5YAeB9qrSB0D9equ+/iWklfI0kn3E4gt8dqqdwd3nVIA+l7P/mk+tt2BqsCDdy7rdd2PZVoNeGZX051i+Tg4ohcI2Iot6kdmLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHFD7XvAR8Cxx1te5sDZg+E93wQ3hMNSR4btW6dOqXw=;
 b=nD3Tt5gf5rNFvpK8Rr6rISpBpQsEi9cHTXqiQrvRD5rVzadWj1RdCVObVmxDDeQA1EgAoAWV6JRLX/ZokxQmmDOqPn+AV8dOqOLvduH/kQvsXoJgTatJAUDOmDz03cRUCf2aGOad+vvDCb+O/c3JBz5kYuYN9MWZoGquSIdHnZmkIHkGdpcfm61cE6qYt/YH70u5lZnmCaPutGQX+uaqYDRH/RuZd2beLqoORA4RgUFbpmWfGuvzo9DSvduWDdEcAOOOy/BiOvAsB9Dk6R1kChoAf6ou5w9j3nqXIJPCHPl0FLtI3m6imFjMdxZXg+IiYcaOoM56wboP2ALMVvf8PA==
Received: from BYAPR06MB4296.namprd06.prod.outlook.com (2603:10b6:a03:10::20)
 by SJ0PR06MB7613.namprd06.prod.outlook.com (2603:10b6:a03:32c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 19:29:44 +0000
Received: from BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::c90b:a5f3:d41a:f8a3]) by BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::c90b:a5f3:d41a:f8a3%3]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 19:29:43 +0000
From:   "Mora, Jorge" <Jorge.Mora@netapp.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: help interpreting nfstest_lock output
Thread-Topic: help interpreting nfstest_lock output
Thread-Index: AQHZVl/4FVNZQNP3r0q7VcEnVye7v67/TLyg
Date:   Fri, 17 Mar 2023 19:29:43 +0000
Message-ID: <BYAPR06MB42961A19F9EA7E36C0A7DD30E1BD9@BYAPR06MB4296.namprd06.prod.outlook.com>
References: <cf9346c3c686fa3b1d193d848d6f82cfa01ffe05.camel@kernel.org>
In-Reply-To: <cf9346c3c686fa3b1d193d848d6f82cfa01ffe05.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB4296:EE_|SJ0PR06MB7613:EE_
x-ms-office365-filtering-correlation-id: a108d8a0-5b2f-4bd5-82bb-08db271df5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9/TlicW6oPIeQgPlVE03SH+fhoem5aIUujLCc8bUZoSVDyJk9a08U9MA32j9iZEX+yiteaXTU6+bApgwvusrlBBrfL1MIvD8BOtaL+FB7T9ezM6XLTdH5Fa2WkWv0CrJ+SqspPhSZoWY3Kjm5whZAg+XltsiYx0USfinqawnnXoHIcDncUuyKkUrg2qzc3wPZv5KnfrnDaPhICeCx3OfiEQzoa1Q8as9hTk2qaUSoLYve99FLthH1YR5uFdc35c+Fdo0Oj7df7NnlHKJdMyeljGVbelRcm3m36kIfbTiFvX8lD6tIWiSAXL0B+QOh93Na/f2542Q3siG39bLODzCpp1kOvl+kCL/NBjTG7lcmm4+WLx3SUJc5H67mbx5Ivn4HxVsJfGLFuekwZ3lzRfHHQhxrX3tfTen7G15jpuknYYAgjR9SsJN2On2/M3E9gnKiZXKVvBHFyPeowdb+ZvXrcuTmPBcxbrrMdq56WkwMabn4HXh87mXforc5XRu+8t50zH67Fc4pJjGcHfO+IC4rt6b1/vUy5HuF2J6KwVzzjDAA4sx4hhFqmDbY6lBz1E49JXOYftmbHRAii5WC9kHpcpD/ESZ8kHHkCJLHxi4vYxCWkpZt1PzBd777KYx6zkNJgCydFjz1vfud7ZsjD9dygujF41P5iBKAUGJDrWh/VbWfLAoDf/Igu+cbZkeIKk9lpN+7844oZzFsANU0+Eww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4296.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(84040400005)(451199018)(66476007)(64756008)(41300700001)(52536014)(8676002)(33656002)(66556008)(6506007)(8936002)(2906002)(6916009)(4326008)(53546011)(66446008)(55016003)(26005)(122000001)(38100700002)(54906003)(83380400001)(186003)(9686003)(5660300002)(316002)(38070700005)(91956017)(66946007)(478600001)(7696005)(71200400001)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9HD5dYVijaFW7pqjhPm0P5yXlpDHi25FREz17trOUvDkSnWiIK2Nb8btOp?=
 =?iso-8859-1?Q?B01/R1n9ehNhPlPL2ff3xbuXqGzgZavQ1akM9HRRaAm1lUpum7GPFkfVv0?=
 =?iso-8859-1?Q?8a0uvwbHmJcnPzQLCAhc6OIlzk6649SGyayCGTFmX6c4nJ557uLjq2zjxr?=
 =?iso-8859-1?Q?lfraO0f1B6e1/iLnEAYqKJ4PiQ0ZBxaHTf1I+EU0n3iFAT3oHGkgiIXI/B?=
 =?iso-8859-1?Q?GagFnnF4SAGcZAVWXbIz4ItaIK3bm74cQ9Eg1n+EGNBRF1/+zGyUVFMH3U?=
 =?iso-8859-1?Q?biGZzODo3SHpFNNlchcGimi9FHkAM8bo3avjF514plm8GgZWwOQwX7EuQI?=
 =?iso-8859-1?Q?8pzeyr6s66EdAsoNOwYMHX6rC5GY4NVJTiOr7/UWR5UI6JGFwRhYKG2nrn?=
 =?iso-8859-1?Q?qHxd/8CqSZF3tSnB3CdFMWPih3Y3Vk/q8VL5PdHN1Wuz16zSZpq5+kg2AM?=
 =?iso-8859-1?Q?5Vs1z4ITqk2rtJb+UneQNBAvPeEBqI+VyRjcrBI6h9iB2K+RoeG4qXkr9k?=
 =?iso-8859-1?Q?MZ/pCHqllc9dGdudZhudqHeCS3yylHqEct8NhLnvZtoju6vuD0zy8BMER9?=
 =?iso-8859-1?Q?ax79YQIaDsX4RZeoScsSVh4q0hU7qAGcSxmLt80HoABWgWnsD7TK0gVdFS?=
 =?iso-8859-1?Q?8Td3iSLJLjEr5qJNk89y26KbV4QRSugyRctaPFK9p/VO6e1rC0apnH3ITj?=
 =?iso-8859-1?Q?b+T7Ho/WY7/COnn9a8snyRvWrIBM3WZEU/prxfg9nIjlrOSyvK9eA4EPd1?=
 =?iso-8859-1?Q?V4oj3IxT3ADU2CFNdQeEl1m0KDpQEIx1U1mB+x2cXa34/Uut3CivlFyQf2?=
 =?iso-8859-1?Q?ZkGooWKlXrw3Se0fEY6otXDCAQxsAenIJSWkE0CPSD/7ino1P0yvQIsS7M?=
 =?iso-8859-1?Q?izWZQ7UbDBiNC7O1YaHZhyGT6aeMQPsGkqDndvJThHo2stpyx9uJXC2Px1?=
 =?iso-8859-1?Q?EHUi7bMBtZdaAc+RnAI6LFG0ETjhDD7qFWynCmScOfKdPohognIpcbtOW9?=
 =?iso-8859-1?Q?ll/qGBmF38PQWpboYqbf5fPRl2t6mjaKxkNgWes/TvjHmem79j4zzqQjnO?=
 =?iso-8859-1?Q?kpzNbD90YR8z92uFopbC4QUlYT/6FoRjIkHICB4OKRQQtdzxy8ZdKLuQI8?=
 =?iso-8859-1?Q?c5fTdGsvJFzQikkI+5h41Mcuf7H9Z9LZ1dJBCUzxK0ft35/SnRefJgBFh8?=
 =?iso-8859-1?Q?9jzrrilGOBBAaw25dfCz0W5zH/yXc7og7kr1axGo7sxQBjWxRybkzMY0hr?=
 =?iso-8859-1?Q?kWstEN1he2nZcqFhg8JPgiTcVkul5bKvWFBMg2q9kqx9v0KEYG8Pg/YAM1?=
 =?iso-8859-1?Q?eNJYxF5AfVfOBsbLvNlXckdw7cQv6rjiuAdDMeL/DeSELXt5+LxTR88qN1?=
 =?iso-8859-1?Q?iqt09sVuNYJe837HO3WDiKqDqnxDA+HNkce4CDmhmLPRA1wtNHCBKiHV1b?=
 =?iso-8859-1?Q?5tuAR1CnM7MJpshFeYenovfAAMKfuPidFGafyAEi9phckFl70/kXWpgDlO?=
 =?iso-8859-1?Q?SRlaN2xPpiYNRFHa/CVwBLQSkgZ5VSYPfnN+8DUSQheDUkb0UpUqWM1sEJ?=
 =?iso-8859-1?Q?9TPn4il9T3vK7bupxXh8H07W1dUd43wf+zw9NwBVagovePu+Bx2QBSM1wE?=
 =?iso-8859-1?Q?uzxORsvRZE3ZA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4296.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a108d8a0-5b2f-4bd5-82bb-08db271df5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 19:29:43.3666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xrz9g9vMgdKn9SXNSVyARRHqqmJA4jgsoz6p5gizMt/iCi3shFpfr6XjI2j0/fXF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB7613
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Jeff,=0A=
=0A=
Sorry, I missed you e-mail.=0A=
=0A=
On nfstest_lock I always use the --tverbose 2 option to display each and ev=
ery test it is running (I should make this option the default for this test=
 script):=0A=
./test/nfstest_lock -s knfsd -e /export --nfsopts nfsversion=3D3 -v all --t=
verbose 2 --createlog --rexeclog --createtraces --keeptraces --tracepoints =
nfs optest01=0A=
=0A=
I got some failures as well (RHEL 8.7 client using a RHEL 8.6 server):=0A=
=0A=
Logfile: /tmp/nfstest_lock_20230317_124056.log=0A=
=0A=
232 tests (226 passed, 6 failed)=0A=
=0A=
The --createlog option creates the main logfile.=0A=
The --rexeclog creates the logfile (*_01.log) of commands sent to the secon=
d process.=0A=
The --tracepoints nfs enables and collects the tracepoints for nfs (*_001.o=
ut) I don't know if there are any trace points for NLM.=0A=
And finally --createtraces create a packet trace for each main test for tes=
t scripts which does not inspect the packet trace like nfstest_lock.=0A=
=0A=
ll /tmp/nfstest_lock_20230317_124056*=0A=
-rw-r--r--. 1 tcpdump tcpdump 243420 Mar 17 12:41 /tmp/nfstest_lock_2023031=
7_124056_001.cap=0A=
-rw-r--r--. 1 root    root    398590 Mar 17 12:41 /tmp/nfstest_lock_2023031=
7_124056_001.out=0A=
-rw-rw-r--. 1 mora    mora     33618 Mar 17 12:41 /tmp/nfstest_lock_2023031=
7_124056_01.log=0A=
-rw-rw-r--. 1 mora    mora     77438 Mar 17 12:41 /tmp/nfstest_lock_2023031=
7_124056.log=0A=
=0A=
In the first few tests, the main process opens the file for reading and it =
is granted a delegation, thus no read locks are sent to the server for the =
main process:=0A=
3 2023-03-17 12:40:58.775615 192.168.68.87 -> 192.168.68.86 NFS   v4.1 call=
  xid:0xacbfb9d7 SEQUENCE;PUTFH;OPEN;ACCESS;GETATTR CLAIM_FH:0x1bccf28d acc=
:0x01 deny:0x00=0A=
4 2023-03-17 12:40:58.776120 192.168.68.86 -> 192.168.68.87 NFS   v4.1 repl=
y xid:0xacbfb9d7 SEQUENCE;PUTFH;OPEN;ACCESS;GETATTR stid:1,0xcfd443db rd_de=
leg_stid:1,0x776824be=0A=
=0A=
=0A=
This is the first failure I got on my run for test optest01_004:=0A=
    INFO: 12:40:58.853433 - Running optest01_004=0A=
    DBG2: 12:40:58.854301 - Open file for reading [nfstest_lock_20230317_12=
4056_f_001]=0A=
    DBG1: 12:40:58.854544 - Lock file (F_RDLCK, F_SETLK) off=3D4096 len=3D4=
096 range(4096, 8191)=0A=
    PASS: Locking byte range should be granted, lock1(O_RDONLY, F_RDLCK, F_=
SETLK)=0A=
    DBG2: 12:40:58.854643 - Open file for writing [nfstest_lock_20230317_12=
4056_f_001] on second process=0A=
    DBG1: 12:40:58.856974 - Lock file (F_WRLCK, F_SETLK) off=3D4096 len=3D4=
096 range(4096, 8191) on second process @2.01=0A=
    FAIL: Locking with overlapping range on second process should return EA=
GAIN, lock2(O_WRONLY, F_WRLCK, F_SETLK): no error was returned=0A=
=0A=
=0A=
In the packet trace, I added markers (a LOOKUP for a file with name as the =
test) to know which packets belong to which test. There are no locks for th=
e main process because of the delegation but it is clear that the lock on t=
he second process succeeded and it should have failed:=0A=
55 2023-03-17 12:40:58.853572 192.168.68.87 -> 192.168.68.86 NFS   v4.1 cal=
l  xid:0xb1bfb9d7 SEQUENCE;PUTFH;LOOKUP;GETFH;GETATTR DH:0xc2e69d7e/optest0=
1_004=0A=
56 2023-03-17 12:40:58.854073 192.168.68.86 -> 192.168.68.87 NFS   v4.1 rep=
ly xid:0xb1bfb9d7 SEQUENCE;PUTFH;LOOKUP     NFS4ERR_NOENT=0A=
57 2023-03-17 12:40:58.855007 192.168.68.87 -> 192.168.68.86 NFS   v3   cal=
l  xid:0xec26b3a1 GETATTR    FH:0x1bccf28d=0A=
58 2023-03-17 12:40:58.855577 192.168.68.86 -> 192.168.68.87 NFS   v3   rep=
ly xid:0xec26b3a1 GETATTR    NF3REG mode:0775 nlink:1 uid:1000 gid:1000 siz=
e:65536 fileid:154=0A=
59 2023-03-17 12:40:58.857401 192.168.68.87 -> 192.168.68.86 NLM   v4   cal=
l  xid:0x26b0a492 LOCK       FH:0x1bccf28d off:4096 len:4096 excl:TRUE bloc=
k:FALSE=0A=
60 2023-03-17 12:40:58.857831 192.168.68.86 -> 192.168.68.87 NLM   v4   rep=
ly xid:0x26b0a492 LOCK       NLM4_GRANTED=0A=
61 2023-03-17 12:40:58.858600 192.168.68.87 -> 192.168.68.86 NLM   v4   cal=
l  xid:0x27b0a492 LOCK       FH:0x1bccf28d off:4096 len:4096 excl:TRUE bloc=
k:FALSE=0A=
62 2023-03-17 12:40:58.859009 192.168.68.86 -> 192.168.68.87 NLM   v4   rep=
ly xid:0x27b0a492 LOCK       NLM4_GRANTED=0A=
63 2023-03-17 12:40:58.859698 192.168.68.87 -> 192.168.68.86 NLM   v4   cal=
l  xid:0x28b0a492 UNLOCK     FH:0x1bccf28d off:0 len:0=0A=
64 2023-03-17 12:40:58.860244 192.168.68.86 -> 192.168.68.87 NLM   v4   rep=
ly xid:0x28b0a492 UNLOCK     NLM4_GRANTED=0A=
65 2023-03-17 12:40:58.861183 192.168.68.87 -> 192.168.68.86 NFS   v4.1 cal=
l  xid:0xb2bfb9d7 SEQUENCE;PUTFH;LOOKUP;GETFH;GETATTR DH:0xc2e69d7e/optest0=
1_005=0A=
=0A=
I don't know why the client sends the same lock twice.=0A=
=0A=
=0A=
--Jorge=0A=
=0A=
________________________________________=0A=
From: Jeff Layton <jlayton@kernel.org>=0A=
Sent: Tuesday, March 14, 2023 4:30 AM=0A=
To: Mora, Jorge=0A=
Cc: linux-nfs@vger.kernel.org; Amir Goldstein=0A=
Subject: help interpreting nfstest_lock output=0A=
=0A=
NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.=0A=
=0A=
=0A=
=0A=
=0A=
Hi Jorge!=0A=
=0A=
I recently fixed a client-side NLM bug that was causing some stalls in=0A=
testing. With that, things are running much better but I still see some=0A=
failures when running nfstest_lock over NFSv3:=0A=
=0A=
    FAIL: Locking with overlapping range on second process (47 passed, 1 fa=
iled)=0A=
    FAIL: Locking byte range on second process (19 passed, 1 failed)=0A=
=0A=
I don't see any indication in the test output of what's actually failing=0A=
though. Can you help interpret what's still going wrong with these=0A=
tests?=0A=
=0A=
Thanks,=0A=
--=0A=
Jeff Layton <jlayton@kernel.org>=0A=
