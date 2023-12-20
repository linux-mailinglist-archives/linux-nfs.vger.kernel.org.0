Return-Path: <linux-nfs+bounces-723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92881A72A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 20:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07E71F2358F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C348794;
	Wed, 20 Dec 2023 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lNQpD4P8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k4aebeTP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F230482F3
	for <linux-nfs@vger.kernel.org>; Wed, 20 Dec 2023 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKGfKSe017499;
	Wed, 20 Dec 2023 19:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3xGlAioa2aez4dR7+GNFYkY9MxrkCeVOlvJHaNIRgOk=;
 b=lNQpD4P8zE/r+BQlZNf/fK/iz4ANT+8WTRYjoaWcqIE19TMY7kzyICZgoqyoSL89JkEB
 mtYBcH9cc13k6eW8OYLbt+gLIbtxXnCv+2FOeO3z8/DGDC57fLlKy0ccbet55n5o+Ntb
 wE8uZYCATba62Nj59nBH35gUypmNyJgoiEEggEH+u5YRAHATfOcKtL++XRWnWXsnzuOM
 LgPZU+s7R++3axMc/pkHGYu6yw7fZKAWQTiG1WjrK0pC859BrLstVaNR8fp8CG8S2Tj8
 N+mvC0nxcRJxvC3Ira4v3wnD794Ik2vRKAZPWSNGVJDhewirTwMNcsAn0+fV2ggfwVRG IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2h7d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 19:05:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKI9Q6V022241;
	Wed, 20 Dec 2023 19:05:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b9a4dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 19:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDe30GY7GVLi6fMi2EEQkroooNoH8a2i39ZQbvibcloU7iR2PU7QiJ0AykqCf+LIrRcbkUtYCF/3rIHJgW6o2Lip5ASc+rqV7UcuXpG5PVs4+WtOnJaom99qMp878ygBfMa9TLq430eUYkyRZnqSH2V6Iq19hpMAkQ0vZZ+NPmEDDs0mWG3ViH/G1Mkmo0XkkpI3nc6qy42dbHa4MhjiiuG1PHZVKK37RFBkjj1zroriAqDPz0fHrlROeQvL9PCDiG36XYSSDHGIx74p1zA3GusQ/VwRRaJ+pIc5hSQQWekVW95hbAlInXiENjMvDBhHYGyPZb+z+qcknGPhKWd7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xGlAioa2aez4dR7+GNFYkY9MxrkCeVOlvJHaNIRgOk=;
 b=AXXRAqSk4Ara+7ohVLLAurlM/Y5eAJzyZqlqiS4v9/eKI13HJAXkuEaY/9izcm+AeEcpNO9CKnEGX0Ayc4pXN4WGBWzMPdGyEJz4oAi10KuHMO9gpnGoiH4NMXCNz0oGVerDOUDxqOlX8/UtOLn0VenxsWRoP2yssA6+E1VLab1qbfmjH8eLIyZUkAGnMXT35vBASp3687YUIJkDSRBNM2wLD9uSXutL+iIhQ4jzpkIjZfTM+9/b9KC5UKjO6hDujbf+VRI2Vgyu+KQHoGQjEqRPt/KSBkf0SXf7WYW2LfvyB5EXvcPio7tU599r1T5wPHyw7guJTiOcGlCGCGcN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xGlAioa2aez4dR7+GNFYkY9MxrkCeVOlvJHaNIRgOk=;
 b=k4aebeTPnJVIid3GTW33BqMkyPgnFmaGz+/gNEJ+yqe/YYo7396E/Z5Im4TFh1ZGs+hXyxD7N8aJFrZVy1Qs1AmsJEZ5luBsFFeyi/qZNXis6I+qaalUoGvvwpHsBbUId63E4Gg2C9ioGT05SJmrLu2Cg4puilfuqJUGAE9kkfc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7535.namprd10.prod.outlook.com (2603:10b6:610:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 19:05:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 19:05:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton
	<jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-nfs@stwm.de" <linux-nfs@stwm.de>
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Topic: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Index: 
 AQHaL6BODuJxHzRsvEmtdxXl8tg1rLCrwk6AgABbIwCAAuRWAIAAJi8AgAMC+4CAAA3kAIAAL++AgAAm/oA=
Date: Wed, 20 Dec 2023 19:05:44 +0000
Message-ID: <6BBA7EF5-45AF-4C95-BD69-8D82F37E6074@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
 <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
 <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
 <AD542840-D60F-4446-8669-13123FF00703@oracle.com>
 <217964D3-3808-48E4-A879-37E4D5E463C6@redhat.com>
 <30058A8C-7A1B-4C48-A13B-B071424FADDC@oracle.com>
 <368736f6-7eea-481d-b61c-513df246c554@oracle.com>
In-Reply-To: <368736f6-7eea-481d-b61c-513df246c554@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB7535:EE_
x-ms-office365-filtering-correlation-id: eaed01c6-3bcd-486c-f188-08dc018eab1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Rr1NNaHwIIICDYcyeLHX2nKI5ENmpDfj3SCZCnhsW7xmGC3Trb082STu/mV01PR2UcetWGLwNhCPZ6lE2nXgUnjA1gnXmiVuoTWvpbHnoA99Gqscguy74NDko7ywoNlxPyeSExwRFDFXq4S65U1LhqGn1q2RD161Q7RHbqLWnpCOxNp0hZHQL9IsuFzamPO5+TPYneH2W8CNeaa9GumdnurYjtAL1T/mhE4QsVxm7UX3glIBH6y7q0+gj2pkNRJkcXhPitjftBHMJ6yqK1Y3YXUAj+bV2rihVlSfy/092wskKH20KlxVp7ffDl54QzxY70aP6qr7DIDfOqhJ6Shyux5UaIFD7T5DBVqL9g2iN9x8R3MMYkVWC/YHRKr0tEkJFOne5X68uu8nspJQDwefL6O9jDuLwIsvAknQ/8upNYfY0YmYFhYm/ciXfLoux1tFjziS19duz7rzkI11PfiK0kdM+4htnDwTZ0VWhPsmZwnGlLO6bD4tKsCv2WYS29LjQHX+iNXcWbw2BCoXfCxpo2I5s4959LzcOaCX7Aswqbd0o+1vYYLuEan4i+GgWHKLxF08z6RK4gkuwhSipNwpJlRh3wIFVLtRmDmsmMiOVPHk04GboO7SnlVUKwke8aB5EYJBy9oPFqqpn+a8Ja9DEA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(478600001)(83380400001)(122000001)(26005)(4326008)(6862004)(5660300002)(2906002)(8676002)(4744005)(2616005)(8936002)(54906003)(37006003)(64756008)(66446008)(66556008)(66946007)(316002)(66476007)(6636002)(91956017)(76116006)(38100700002)(86362001)(41300700001)(6512007)(33656002)(53546011)(6506007)(71200400001)(38070700009)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d2xqRzNpSjhuZW1vYjI4VUI2VEJZaEpvTW1EUERybzZDUmwxTXZrMHFMSkxp?=
 =?utf-8?B?VTZ3QXRmcGpGaW96Z3VRRGROMU03aFhSek53RElxWEhmR3lqMzJiYXhQblVl?=
 =?utf-8?B?RW9VQTgvV0g3Yk5xVm5JNFZEb2s5SmsrUmJDb2h1SVp2V0RaTFZmY3pFc3Nw?=
 =?utf-8?B?OUYvVHpsTnp5OTdmSEVLS2RxVkxIQ2ZJVWxIOFNrN1Qwb3pvWXVld01TMXBt?=
 =?utf-8?B?UEFYNlB2enBmZnpJZUFtdmhsc1VWUGtOQXJ2ZldWSjMyTlIwdldmMTBEbzBx?=
 =?utf-8?B?YmxDWlFIcjdiN2gxbzJNaFlGMG9RZWJSLzhlMnVpM2xSaHp6dkNzS1YyTVF1?=
 =?utf-8?B?RERsZFpOK1ZSQy9tS0ZyNGE1V0VDcWkzKzdIUUVBdzhuOXlaSUxVZjhvakRH?=
 =?utf-8?B?SktJWVFiNCtyWmQrTkNtNHNJMFJpck1RMmhzczAwSDRnMkwwMk0vNjAyNUh5?=
 =?utf-8?B?U3dPNVQvSVlXY2ZHSkxyOWxxYkNQdnJvbWV1YjlpeG5hdEY2MU41bkgwblNz?=
 =?utf-8?B?MW4rWitmc29aNzVnUU9FSEx0QkhmV2MzMHZZTU8wb01OOXNuVDVBYmthTWM0?=
 =?utf-8?B?Yy9KZVQwKzBOb2FhQldwUlVuc0lKcWp3YSswbDUyN2ZCZXNRM0EwRXlZYitC?=
 =?utf-8?B?cEc0QXNZVXN5c2dBa0tMcXZBTEx4YUUrUGMxN3U5N2U3eTdWMERucVd5WnF2?=
 =?utf-8?B?WlJ1NFEvT0ZHVnNMTWhoTXZOaDRnSHgrZ3RBNGhWNUhkVE1EZDJmS0lHOWdw?=
 =?utf-8?B?Yk15RDk5ck9UcFQ1b3d1QVFIdVBnWnVXUk9vbjBqWlhXR2lkRlZPdUcyYkNN?=
 =?utf-8?B?eXhXeXkrRlVuK0R1aEg5V2wrakpkblIyczBHOS9PZDQrTFRzTTQ4MHpkUENF?=
 =?utf-8?B?RnMrbGkzWTJaU2ZUNm5ONjBaRFY5N0lmVFFRZnRoY3RyaXJ1ZGJVeDNIVk4w?=
 =?utf-8?B?YTg2cUtVQmI2cElsaDdrN21CRmFwUXpIanFPVkNnVjZZTzl4a0g2ZHZaQUlK?=
 =?utf-8?B?QVpqTHpOU3ZSUlowRE9jNWh5VXFuMldGMno5c3R4QmZPZ282Tko5ODBRSklX?=
 =?utf-8?B?YitqVHM0ZCtFUGdHUmdicEZDNGlrYktZNmRncGFCVWZoRlF6MG4yRk5CTzF6?=
 =?utf-8?B?d2k4ZHpEdVUrbHRqWFRBYVpUWXNKbXQyNEd3VFBaQVVFUmMvdWswOXhwMms4?=
 =?utf-8?B?UGVBMWk5YWFYUnB1TnBFMXBrZDUzN2NOQTd5WlNRaG5tR2NtcWphWFZDMUdS?=
 =?utf-8?B?NjB4ZTdnNDFzUW9HYjdDWmcvOGNyQndIenJNNkRRVVE3eEdwaFV6SW9RYTgw?=
 =?utf-8?B?TzV4ZTlDOExKeFFnd0ZiZ2VoUUJNT0k3VUlJWkJ2QmZ3MUJ3ZUlGVTEyYVh5?=
 =?utf-8?B?S1EzTWZGeFVDY1c2NW42TWdVK3pNclpQU3UvbjVCbkRKVG9zT3dORkFCOEdI?=
 =?utf-8?B?cE9FcFZsTVNOcThPK0Q4dm9WS05uWE1qOHgrQnJsV0RMMktmTkFmbk1iU0dC?=
 =?utf-8?B?VTRSTWZucWZ3WklGUlhCTVFoM1F1NHpKU0t4NEJsTXhzbHpScG5kSWEydCtx?=
 =?utf-8?B?Zmg2RERGKzBZb2FPaFFTVHZLREMwZm1nY2pjZG1lVHJIYjZDUkUybFFaR1hN?=
 =?utf-8?B?YUp4Z2hRcitUcUVTVHV2UkZPLzlKTHc5bDcwUGp5ZXpYMlZxZVZabElqNWtl?=
 =?utf-8?B?VmNGYWZ4Nzh6dGI4UWpuSm5NOUpGaVcwdVYzLytUbllQTGdKN1JnRVJLd2FU?=
 =?utf-8?B?aE11bStMM21vOVNWTFhwTEdzRE9COUdUS3B0bCt4Y1dDUmpTcVhmNTlVUkNZ?=
 =?utf-8?B?dVEzclh5c1BmM3ZvZzJwOHNlcDhzenZicEdLcVdEdjFOaTBqOXFRMGNRRU8v?=
 =?utf-8?B?QWRCV25jbmEycGFPTncybUptR1Z6ekFqNXJVRFNmTmJRRlpwYmJsVmlJVTZk?=
 =?utf-8?B?Nm5ZMk81bEw0emdmQ2VtZ0ZCdFN0c21mL2tqSURyZmJ2bUZNYnpzL05jNnhT?=
 =?utf-8?B?ZTM1R1Y0WTdoeEd0Z2lhZW9MUnZZMlY2cVBqV2w5cXhla3RNOEN5bzdKQnVl?=
 =?utf-8?B?U1VJL0E1Z1JlcTUyeDdRaTk3anRmOEFoMENKTXIzUEdtZDZjMWpUTTJNaXMv?=
 =?utf-8?B?czBDem1iQVNnTjlIN0ZibXVMVlFmOFAyMHNYQTVXQk1EcXRwcm9rUnJrY0Jk?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <420873506805EB419A989BABD2EDD92A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3LWI0SM2O/vMZBq3zIt9U80U4mQasceZmLi91zabnsaIRelJ65Iah9ZtMy2KCzzohUUpt7KL1Gw1vJXxvgB2IbUGePtej9+sJKjavIPjp8AgPYWW5w845EA5x3UAAxQGNYijHtrt6nhQpwV9CCCaHNMlNdZoLeH7YkrlHeE0OyrXKKXf6GUIhy31UCfb8ZhVCoGjbmppB9lCnxpeuI/fiDBAqMfvEGdw3pW1AjdFVRDtNnvnYREDA9ZLQrSSfOWwgQIAdjr3ty11MXp3qcXWfQ7t/Oosq1Dvi1NgfZUsQYe94FXy/j9JS1etJK/89Nd+dnfuq3gZiotsV6HEBCRbiY+F+etp1KwiG3vDXXMcm7wyCF3osSYoMYIwYs2Yka9MNvOEeeykXGb1bvugoU3hUKKiCFLXo//PAE3GmCpbcGFuagGsS0GX2jeOrtrjQLxO3srMfPNrmVwGpPcmtXa3m8nZNeXki6+7ZJzbi/63+aoGoYDK362CiJGRCiqdfP0k2MesyQnxocsjpnfUz7cpDUeXPPJ7ibQ59QD1GW+apq8UlAowxENvhvkfWk1yWYTXJL4mfI8s8fiQwq4zz/6YiX0NBFaDHENBVHvy5RfmjHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaed01c6-3bcd-486c-f188-08dc018eab1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 19:05:44.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Db0qP0W08I84JxZsauCT2YUvHxpAXP89ZcSv6GdDAClCpZmlf7/LH5a40qMGXOaHoc36eKb7KkDCzOgNW42Anw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_11,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200134
X-Proofpoint-GUID: zy3yUqjRAqd8a3693z2A5i53uqjb_9im
X-Proofpoint-ORIG-GUID: zy3yUqjRAqd8a3693z2A5i53uqjb_9im

DQo+IE9uIERlYyAyMCwgMjAyMywgYXQgMTE6NDXigK9BTSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFj
bGUuY29tPiB3cm90ZToNCj4gDQo+IFRoYW5rIHlvdSBCZW4gYW5kIENodWNrLA0KPiANCj4gSSB3
aWxsIGFkZCBhIGNvdW50ZXIgaW4gc3ZjX3N0YXQgYXMgcmVwbGFjZW1lbnQgZm9yIHRoZSBwcmlu
dGsuDQoNCk5vIG5lZWQuIEkndmUgYXBwbGllZCB0aGlzIG9uZSB0byBuZnNkLW5leHQuIEknbSBz
dGlsbCBvbiB0aGUgZmVuY2UNCmFib3V0IHdoZXRoZXIgdG8gYWRkIGEgY291bnRlciBvciBhIHRy
YWNlIHBvaW50LCBidXQgdGhhdCdzIG5vdA0KdXJnZW50Lg0KDQoNCj4gLURhaQ0KPiANCj4gT24g
MTIvMjAvMjMgNTo1NCBBTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gRGVj
IDIwLCAyMDIzLCBhdCA4OjA04oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJl
ZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDE4IERlYyAyMDIzLCBhdCAxMDowNSwgQ2h1
Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+IA0KPj4+PiBJZiB5b3UgaGF2ZSBvbmUgb3IgdHdvIGJ1
Z3MgdGhhdCBhcmUgcHVibGljIEkgY291bGQgbG9vayBhdCwNCj4+Pj4gSSB3b3VsZCBiZSByZWFs
bHkgaW50ZXJlc3RlZCBpbiB3aGF0IHlvdSBmaW5kIHdpdGggdGhpcyBmYWlsdXJlDQo+Pj4+IG1v
ZGUuDQo+Pj4gQWZ0ZXIgYSBmdWxsLXRleHQgc2VhcmNoIG9mIGJ1Z3ppbGxhLCBJIGZvdW5kIG9u
bHkgdGhyZWUgYnVncyB3aXRoIHRoaXMNCj4+PiBwcmludGsgLS0gYW5kIGFsbCB0aHJlZSB3ZXJl
IGNhc2VzIG9mIGtlcm5lbCBtZW1vcnkgY29ycnVwdGlvbiBvciBhDQo+Pj4gY3Jhc2hlZC10aGVu
LXJlc3RhcnRlZCBzZXJ2ZXIuDQo+Pj4gDQo+Pj4gSXQncyBwcm9iYWJseSBzYWZlIHRvIGlnbm9y
ZSBteSBmZWVsaW5ncyBvbiB0aGlzIG9uZS4gOikNCj4+IFRoYW5rIHlvdSBmb3IgY2hlY2tpbmch
DQo+PiANCj4+IA0KPj4gLS0NCj4+IENodWNrIExldmVyDQo+PiANCj4+IA0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=

