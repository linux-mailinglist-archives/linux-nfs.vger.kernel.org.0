Return-Path: <linux-nfs+bounces-170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBAD7FDA64
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C4B20E10
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D734568;
	Wed, 29 Nov 2023 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="qd4zLn7B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2127.outbound.protection.outlook.com [40.107.220.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9376C4
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 06:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUFQQKmHRhuOgfIIuLxITopLSmcz8fSf/i+B8xno6mUEtNG+eQlgmHiM9VVCMv+yuJSm/C2htyzR7ifHSxQuG1O4pavAXPTuDUsYzhcE/W2LIgRUJE5OpS53W8HlT0VDaaNGvBTpg+ZkxJ1LgxFgTCi7fu6qGjJCE52z1yEIvGnXA3e5XPCSQHOOh8XFy4KZIQS01LGYapypaISrcq63+VFtKS34iHnqHM+2ofLVpxOL9ZwU+pW3Frg1SjVAiVKsrR82euFlVpdZE0862in0p3ZUqBv7ajnNHdQfhMWGf9FubVoxftdPdf/AUbSOwRI9M9Ic76/8wa1QnHrRCTy9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBbysqmq6QdyacTRa4jNldzkYnMSSV/TprjnxsWOJK0=;
 b=KX6SC05RZsnsLlcqJZNbFs50FGFao5hHXBeKXx3nsBaZcU952S2At3Vi45JhQ1gMkkWFgFvE+rqjKSGkcLQaR4oOfNUKTBjqDg0AkhYvAjoZbmDogHmoIcICxIdguL0STK/hoBKCCaHYwHZ5q5v/0qno6H+9a/oOoE+kdGqPQw3pWo5QQBKcQoSlCYTIE2/ascNrx6W0itc2RaoUHc+nN/VJoDb/wANCEQDesNCKgRxJBjGkzfIsGNY0jYd07jKdsPm6dk4JDtzMg6QZ5xA94X41D2wA6xqs+s6ZBSVnNIBEp7yQqqEh7BFrTwcs/FDV+DMZIZbt7BVy5UR8ziaGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBbysqmq6QdyacTRa4jNldzkYnMSSV/TprjnxsWOJK0=;
 b=qd4zLn7B/sbXp/es3pShafF7Dj0uzeLsXk6f+n/oBEb1i57Ktc6Qsb83jeXAtzVSktmtZ9kkg9tCdJIo7JzkvDd96bwO+4uFJXRkLwF28rnNYS5MP0XEr2h/5x5fGgyjhFiqAdEdaZkN9WlzgbAAKvA1lXEEiWl12tLBr+GaKO8=
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by LV3PR14MB7529.namprd14.prod.outlook.com (2603:10b6:408:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 14:52:17 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::e258:1e42:4907:1336]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::e258:1e42:4907:1336%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 14:52:16 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: what data can I collect to help with nfs 4.2 hang?
Thread-Topic: what data can I collect to help with nfs 4.2 hang?
Thread-Index: AQHaItJ0+eWrp1j0k0GKs7tH7W4Mag==
Date: Wed, 29 Nov 2023 14:52:16 +0000
Message-ID:
 <PH0PR14MB5493C1FB56B38EA846B2ABB5AA83A@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|LV3PR14MB7529:EE_
x-ms-office365-filtering-correlation-id: 68913370-7cbe-4af4-0354-08dbf0eac7d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FanvxijQcRCM7UaPNl0Ic2neyqJAJR3O80ekHZ3bf8wPE7SZWQk/enOWJS66Fi6/D6533r5xFYZnwS5T0Zg6Bi6P6y6WdRpTfbdLqzGIMo0MZH8T1yvN+hulTuKfnRuka/u/xVLo8dq/y8yMr9Zd3M5J5A+QphfqeMcHVMW/7P/k7lF5c5Xt4NDT7M3X1kIWYtjYwZzxIq28emruiLPhTElC2dQx0b2LpdOFlWz+1QwaxpgD2IctdwQi/F2ItmUyJ6BiH4lkC56vX+0aCyx3/5Ssiax2powk3HjXPdrEQoCxr908TVoJmr780guseeW+FKGKZKw/mgeiLBT2FV7BfVwekpOGZqwXdsmzqmTIl8Dqxds9AMZeCpqjNAcSyrSivumqIyJx8dCGgEBztTEHaELP+KBERuEigS4EDFF2V6faVgpYduGpH8KhHaz6FCzMK863BAfMSqp6Ut1/JtIeEpnEJzKTDkMfBxaFPo71EG9avkJ0Vz1cZ619kYJ/iTg7YxE5GFvUwZqcXwcSLmaoDz+p33Cm4EyN1qDTr1PtdJ/dSrt6PgTuAk14wIvNMoA6g+rScZFj2RLEdE3oVxrU3+7XCJ2hZQYl/Tuw+8F4Vc3zvRBnLK09aWm3+COk6IgL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(75432002)(76116006)(38070700009)(66446008)(66476007)(66946007)(64756008)(66556008)(6916009)(316002)(786003)(91956017)(2906002)(8676002)(52536014)(8936002)(5660300002)(86362001)(7696005)(41300700001)(6506007)(71200400001)(9686003)(33656002)(478600001)(122000001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iRaTr9u8sAFImKjd7qh6BISERTH/aAIhhr/ceCiOGPjCE0U98nz3iMHVut?=
 =?iso-8859-1?Q?SvDY5+36mV+grZVE3uf84OtMdQsH7DOsavr/A8VBW/ttzpJ68x5JCpSOoY?=
 =?iso-8859-1?Q?U20SqCiB6rcwTjZiXHfB4JKiGmCrZNTFXzJsI76Zi2sZaTdU5Gl6Ln7Pzm?=
 =?iso-8859-1?Q?ar9eDyhmZxnVsvy+GrLfBQuSX+A8Eeq7w0DtZxT/K1eEIWmLPa7jhztFW3?=
 =?iso-8859-1?Q?az8HLW+IG+8cnsKzqXkliWSlkY/0dU8QYCYZP1vfh0VpVyjKO1PRhiPWtG?=
 =?iso-8859-1?Q?blmTUjGocbXvbH7xjBNSsICUeipJB5UWWv3Ul/qvC97N5itq7gBEJUDX7D?=
 =?iso-8859-1?Q?JWDdLBScgpggnyfY6P72uKjzkdg6xI9EmblRuPLkn/MLUJGFvADWou574O?=
 =?iso-8859-1?Q?ea87lWxE5gaYiIpzCaVtvcJy53jSqX8p1dTvPqombtyS2O39yxWYZQWbL0?=
 =?iso-8859-1?Q?5qPdg24QP7SRWFu39v8UKPfsgztQeZAG59O2cYo7BytEzplq8Hv3tCc3WZ?=
 =?iso-8859-1?Q?Cta2Zt7chMMBXjNfU2AG4mTMkLpKS3+wEmLYi7UUaFBtBcpHEbeQLQubvQ?=
 =?iso-8859-1?Q?b5W4BHbVMPa718yA5dZbuj0YfvZtZQhPbpQGSdVTScZkDWY7p37x5gCdXK?=
 =?iso-8859-1?Q?/j8JzIWTJ/pQ+S6SoMJzKsDWekm22icS2f0jPrsXQWFck5tzvWe9su2bjj?=
 =?iso-8859-1?Q?1icU5KQ1OC06emstzIg63WP2KtU/0fmxzlsWJPVMDiHUqgYQo12OlFsbKL?=
 =?iso-8859-1?Q?XSIVraWkW3hX6i1dsf5ICPBV+0kVvqlnJZ2JMe/SgFeNpVMKK0Tp/Kayfh?=
 =?iso-8859-1?Q?IqUi9xRc2IVga2D7S+U6zh4k8DByKxWCK9NhKgnvabNlgP6WSg0kZcjALJ?=
 =?iso-8859-1?Q?om9RKetflibmxJanPUKDKIvQrKxhuIrk509bIzEjmPFJf7nOEO/QbQu4Cp?=
 =?iso-8859-1?Q?insPDVPTZwccdZa/OX38mzkAykk9f3ELjbXEVC9iVb/xIhYZqYe0TXs73v?=
 =?iso-8859-1?Q?mDrC8OhOMlVsXfyw+Dh/iXfa+ceNdl9TN71QpJ4fpmDiUiRtR2//FfX0gk?=
 =?iso-8859-1?Q?VdvcqI76BQM8UcvnQzMx9AZO7jsvwOIBqSypdYFO2yU7rOdJUjQIYnEj4e?=
 =?iso-8859-1?Q?RGVkXvPC40Ecy9Ts88Md48XMnjqi9CO8sAV8nXnl75TR1lgt5ejSCGD1id?=
 =?iso-8859-1?Q?Tduj/kvvRma5J1MDfWBHcl8viJ85RN2XK/7Ph/unUi2JOT06tXCgQoogUv?=
 =?iso-8859-1?Q?9f5J7OowO6B0AUw6g1eOSEoZCszJhtLT1sNAa4piXPOG/zsxlo1Fdy9HBh?=
 =?iso-8859-1?Q?yhdnpDfn0mva4ryglbhmXlvBwXp+2LwBs4AkyJJOeySD92Wg4tTey8WwpI?=
 =?iso-8859-1?Q?zyfyoi6tJRCB+M9gRaEYkq89llkQ3yXPx558c4teDA2EaeyA7pTRU8yR7E?=
 =?iso-8859-1?Q?kX8YZH9h5bHMr9F6qiVMBj6PtPhGI+9i/iAfw06jarybMPDiD1N/ED/h8J?=
 =?iso-8859-1?Q?/KV5HVGryK2ou+Kn8GAP/FZyhFLQ1n8SqIUgJJDGsPRDvxhTHL+JH5lCps?=
 =?iso-8859-1?Q?dKDu55fcjUBmXKOdfTac2p+vEWS9/iOR3oD+BTdIX2FbneTOpTup7+0H4X?=
 =?iso-8859-1?Q?K8dZLwnLYXk9c6v2HSOBhIPDZ67CQ9QPUdpHigLdo3kR3WXbP/WkPC8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68913370-7cbe-4af4-0354-08dbf0eac7d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 14:52:16.7939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hqk4V6yF+ZreqPaGWdTODvIhtz1IWKx6Jbi0U2IIsBoCSOEn5bi0FuDKTolznlkakRhZ70gkUEXsHWSRmZnz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR14MB7529

I have a departmental server on ubuntu 22.04 (kernel 5.15), where peridical=
ly logins hang, due to the home directory hanging. Reboot of the client doe=
sn't fix it. Backing down to nfs 3 does. The only error I see that might be=
 relevant is in kern.log on the client:=0A=
=0A=
kern.log-20231129.gz:Nov 29 00:00:41 c207-01.cs.rutgers.edu kernel: [283739=
70.471104] NFS: state manager: check lease failed on NFSv4 server communis.=
lcsr.rutgers.edu with error 13=0A=
=0A=
echo expire > ctl on the server hangs. Sometimes I get a backtrace in kern.=
log. It's a bit long for this message, but I can send it.=0A=
=0A=
The problem takes months to show up, but once it does, we get about one sys=
tem per week.=A0=0A=
=0A=
We don't want to abandon nfs 4.2, because we'd like to use default ACLs. Bu=
t we can't until NFS works.=0A=
=0A=
The problem also occurred on ubuntu 22, with kernel 5.4.0=0A=
=0A=
We have several file servers. It only happens on one, with our home directo=
ries. One peculiarity about this server is that we have a very high rate of=
 locking. We have up to 10,000 lock/unlock operations per second. This is b=
ecause of how Gnome and the browsers work. I should note that we have disab=
led delegations because of issues in 5.4.0. I'll turn them on next time we =
reboot, which will be in January. (Because of the nature of this server, we=
 try to keep it up for at least 6 months. There are 2 maintenance windows p=
er year.)=0A=
=0A=

