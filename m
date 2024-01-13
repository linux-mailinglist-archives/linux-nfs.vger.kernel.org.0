Return-Path: <linux-nfs+bounces-1079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B3882CF58
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jan 2024 00:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AE61C20EE0
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 23:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009115AF9;
	Sat, 13 Jan 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SIuLH5ix";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FikZkYRe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93636FC2
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40DMr7qX013703;
	Sat, 13 Jan 2024 23:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2FlFPMlThVuKXYSIs1oKdbKtrA+GFFdgmtAWADOYjmk=;
 b=SIuLH5ixb9rQxkNerPCN/OpcHE+s5272qGXWts3wg3HgPK+uTY7/N9MVy7ZP6vqpV4BQ
 Z03uQrH9f5rzOPq+X4DS7GqrXE6iXrcIDO+uHTOQtZowdPnZKGXiCr/I0z+IPP5pnm9V
 bKHLhK0TffAeSJV9TA7HwgwjWiWJVbl36ZIEECBVqfV3WLeSWvLHhzeOXilAa9HyA+Y2
 2aLTMuU46y1XHMNrnXj6rxL4AG/mivStwH/ltOUjijAecY5plA/AxdVQVYchoUtb4WV0
 2xQa4Mrg8Wxlfdt34OcmZtq05CK8E/25yCCZsRQIInUf55+nUYtTeTGxqyeB4Y6MQDn+ 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3gresb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jan 2024 23:09:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40DJ0QLs035857;
	Sat, 13 Jan 2024 23:09:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy41c54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jan 2024 23:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOmNpr584uEr8JUHPOTcG0OqiZ16YmUpZ0I0o5ZWiDJaZPvUc7xJZ3tznL0K98jtzALyGIB8nuB1zUoFasGRO8iEfdZXI6y+mn2PPutrQi9gpsl+R/QPATm6kwXWBwd71ilDz867gHXT6JwpwnP9Cgs78z4ipCBbni70GMAx/wB1Axo7/mZdmCn8/nEpZPyAaOfJi89ErcGgLBn7U4FbHe/zsUQ0lhotwIH2X3kI7wV3HAPL8BFBsMPPWd/fu0ax0S0E125kNHcvk2yCgkMTiqfRdF+3dEl/yhRmhD7Nzw6VRFiYKwKTzdrQKBSzgTTYvuMdNDL09VFQ4gH32j4New==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FlFPMlThVuKXYSIs1oKdbKtrA+GFFdgmtAWADOYjmk=;
 b=MwjKQRvFOprPwhBkf+borZFZ23cL8cLZraKVPGHPzjtQcQvUoB7M47+v3BMzxBQiVt/DU3wH3Chwly07U1w/mGYdSIceE8FSALpyIfFqnSebWgNE0r75WIe03C440/4D/cJMN5SxdS5AOOQCbqaQnoYGpqqEcI/6ZCYYrHqS8GpipUDNxsogQ7D1t2514VplqZ29MALJlQtcYjb0ZjCKaAiOeDdpr2k5F0YtR7O8tmC+Cp6/DP35K1JI6rKDp2YtdFLPtCqAnxoSg+eRAYK0Gy0n82TuB5b1yDqgsFg9nN8Sa6uG6WyvAK6ZjzuED/+Z5lL5kehDrvAqfh0RY6fd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FlFPMlThVuKXYSIs1oKdbKtrA+GFFdgmtAWADOYjmk=;
 b=FikZkYReUrvdD4MuZkZs+quheHGuDh+GnoPwURGWgSCtxibDDWp9fxHt/9gQxCEYMwHbMRvYQi948hc1KGGdIKR2LWoZBYgAAOuBsyqp1Y8OzAFRqHaYcXBQN/ZlojVrs976ptc28Q1URNe7vdoq02yMVxHhdPk+Y0E1HBjL7zk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5652.namprd10.prod.outlook.com (2603:10b6:303:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Sat, 13 Jan
 2024 23:09:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 23:09:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Roland Mainz <roland.mainz@nrubsig.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Topic: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Index: AQHaRbZPBYb+SPTdz0iA03bgLbzGobDX06gggAAF7ACAABEfgIAAVNOAgAAgLQA=
Date: Sat, 13 Jan 2024 23:09:40 +0000
Message-ID: <A3F7AB9D-1FE7-4D8F-A14A-17521EE9879B@oracle.com>
References: 
 <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com>
 <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
 <3bd49c4ab5ace84ab39df7a0d2c8851542bfb9b9.camel@kernel.org>
In-Reply-To: <3bd49c4ab5ace84ab39df7a0d2c8851542bfb9b9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5652:EE_
x-ms-office365-filtering-correlation-id: 680f34d0-ec64-4889-a4fd-08dc148cb8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GQ9hsbc8uImD3nzXVCAFl3xL2+AHQSbhxsF37UTFkMMZVzee2P+kdrUTKIO1nse+eH8Lif84OfMymbdN0gP+PoL6JbUWg5d3Gx845LjmQc3+BgpVr60Rxe2bsqnmjfRZl3EJWyjp1no+gC/6ohIdH4GJ6i0fMCffvgRouW7R5fJ5gMgtIGbQZaCw64mW9NGPCnDqeg6ZQnNWCnvu+omAxbS9arjHJXlQP+Grb4vcvY1H0LN6CA0AtLtfJtPk+W9Pdx2txHS8LDUEpfSzer9c+QH6AMRQF6Cy1Ez8XW51Ic6BBTrUtgeL+hDvEl38w36M7Gq0ts3JGxdfhU6oZlXHYGG8Q2XgpsJdEpU2WNntcQARvSlFKHqjgwPVMB5d/ACEFEeiPFU6P+sgJLj7tNjEHBeU7OzUdTjiLwr9QsmOKzjp0BDwAusru1zgLzRws8bkvI85gHQLuVaZVpro7VM+Z5MXJtsU+KHBxEQDlYvorPsAo1NlMhJAUxAFwncUgNYiZ/RBz2m/sZij/qyPzegZuRrzhMh2LqgAy3sCvpTdOVQHh5vTWS8c4QX2NlRLu8DjZ7vQnqHqAkgUn/2dhoDQ74uo57gXkX2EQ8C0fHoDv6peubRx0gziMCN2KCYCE+PTI8f+GPzRTTpJ1XgSQ5UTMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(478600001)(5660300002)(4326008)(38070700009)(66446008)(316002)(6506007)(2616005)(41300700001)(53546011)(66556008)(6486002)(54906003)(6916009)(66946007)(66476007)(33656002)(26005)(83380400001)(71200400001)(8676002)(91956017)(6512007)(86362001)(8936002)(36756003)(64756008)(122000001)(38100700002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YTlCV0ZOcGJwSEVqZ3JFZzJjZGdaL29kTzd6K2tNWlF4blZ2TmlTOWxUbW5y?=
 =?utf-8?B?SUdna2JKNXZ4QnprSHNlR2VORlAzRFBLUDNkeFVIeDdjemxDSDZ1eldybnBm?=
 =?utf-8?B?NUF3aUQ1TXVKeDZNelprZ0tyeWFpbFdjdEFSaUFKcFdsUzNSZ1lLVnlvclBw?=
 =?utf-8?B?RHk2emRDbzRsempUazV2aUZFMjhPS2E1aTAxaTk5ck95M0VDNDhkSEpoTWk4?=
 =?utf-8?B?WE5VaHFhMXF2SFd6OEdhRndaVXBOOHZPSW5QM1dxYUFmLzNIUDMrVEJ0WWlJ?=
 =?utf-8?B?VDZLWXNheWIzMERkcnZId2oyK3FkNjU0a053amtodHlOd1hGcTdEQllvN3Ev?=
 =?utf-8?B?ekQ1LzFTbmJybzcvQTVIUUFJY1d4NmJBQzgzMXZ3VmVFMjR6YVhuSlV4NDQy?=
 =?utf-8?B?VVBtMnZEdStYZUdwVGdQMDlsZVpKeHhNZlB0b3ByZHJmTTFaOTRuOSthd1l6?=
 =?utf-8?B?TlNid3ZCUmV2R09VTUdaYzhBVjZkZUwyOS9aa3NoS000MUNwemtZc09uYTdR?=
 =?utf-8?B?elVXa2l3UEFXOW0wbzVmZi9XVzYzNlVMSE1hS2paU0NPSkNsaWxKQ0VsdkJo?=
 =?utf-8?B?aDZCa3h1YnI5a2UyVWNvR3Bmc2QyT2V2YVo2UzZtVzVaa08yWjVrditBMDcy?=
 =?utf-8?B?cW94NTdVd2xqa2lkL3E2QksreGZDMWtRTCtlditwTTZ4em9OdjBEdmNKU2tJ?=
 =?utf-8?B?dmhOcURqVlRSQmVZZXNqTlZnQStydWoxbjVHUk1yZS8yYUJadTFJM3cvNm90?=
 =?utf-8?B?OVo2Ym15WUdreHhvQm5WdVg3Z0tZejZlOUN0YjZYd0s2UWlYTWdLMVlmTE9S?=
 =?utf-8?B?NU1mSlV4eVhndHJJTDRmcEN2TS8rK0w0WWxJczV3azB6b3pxWWN0WXJVcWhZ?=
 =?utf-8?B?eXJJZ2luRlJ4TlhVNzFCQmIxblBsYnhWcWk4RklpY2VOeHNlenVxTjI4eUNz?=
 =?utf-8?B?Z2w2VTg0emR4VUpqczR6bjFsTzd1RmQ1ekxZWmhVWWxZdE9wdjNoTnMxRG5N?=
 =?utf-8?B?UEdwdjRTTHh6SE5YaTJjUzFxd1dNV05qem83aGppekxIajVFM2l4MlgreDZX?=
 =?utf-8?B?RXV5Y3REdWd3YkRma3lXeE1uMlRtZlFUdFJ2eWJMTE1hU3BpWWpsaHovb0Q5?=
 =?utf-8?B?aTl1clQxb3RtRXl1TDhiT2taeWtLdUlNeXE3RHZSR2NOQ0E1WHQyN1R2cXpR?=
 =?utf-8?B?dFVRc3dWczk2cXYzM0daNUdnTndhckRMejhzdUprblYzdHNWbXVJcHpoRy81?=
 =?utf-8?B?NUhFbzdiVXdIZ3Ztbm1lMDl0V3VDaHpCQ1VNUDhlUmp3dDIzVzhhOFZmNzVF?=
 =?utf-8?B?Z1RxR3c3eGZVREZmZ3ZrajMrcXFCZkVVQjdvYVdMcUZDanRCRFNNVHoydElK?=
 =?utf-8?B?aXNpQVZxUDFSRjBKUDdscHFISGFaeXZaRm5sRW9Wcmd4N1V1bTVCNi9pMS91?=
 =?utf-8?B?NkllOU5ZVUNIMkdNRkxiRlkyemtjSEdndlhmS3dLMkM5REZ6c2xsZkk0K2pX?=
 =?utf-8?B?Nkl1bnlqNXJvSWdQM0xCbFI2bnpHR2JZRTNOVXk4ajhlY21GVVRSWi9ONGc3?=
 =?utf-8?B?WVUrMFg2N3A5ZUxCamE5VzRjcVBmNTBtQmNQc3F0djhXTUV4b1QvVnFzQzli?=
 =?utf-8?B?NUF4Z3dUTDg4L3Rkd2hGQXRTZnVtMUY4ZU1LTWdXaXNjdzhrMXZJQmRPSVVP?=
 =?utf-8?B?bnkyRnFnbjFXUzc0Rk9VeXluMmJqbWhWOFB3WGpWaVJZNnkzOEF3M1NjQklz?=
 =?utf-8?B?a0puL1FwdUZGZU1XbzU5TmJTV3J5Q24rYjJsYk9JUXhlcUZ5QjJLKytQRGFJ?=
 =?utf-8?B?L2JiYjFXRUU5azhsVytzL0d3aXpWVHAxVG8rNDZnQ01xWUprbTFCZlJNakg4?=
 =?utf-8?B?YUI1cmlYVEZKZlNDTGh2b0hNZXpMZloxS2lNVEE0QjlGZ0gzS0RXdml3anVj?=
 =?utf-8?B?SzdSa2FoZUo3RVAwK2duUlRIeGYxU0JNZHZFT3UwWmVhSlpnK0pQY1pJOEth?=
 =?utf-8?B?NFpEOVFjSzJENitCVmFQZ2ovL2VmcGtzc1lvUnlJVEhzOStNc0ZQRU5vUkN2?=
 =?utf-8?B?dDVUNEs2ZlJLcDVkL3lNbkVERi9ib0RtOXFtRTZhOGxacnJnbi9qdGZ5MWlB?=
 =?utf-8?B?MzUrRk5wZURCd3hEMmZDazlXYTlMYXVIdHdjeXR5aFRIa3lyRmVneDdyUzJB?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01AD31E41DEB2441B2D0DF7E16FA119A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	todBaLhrwX6m4ZpM1rrbFiX8eRVoz8Aegven6VsxFicPT2Lm+zPgNmKYOJokZMrt5fAivf330D9DmgCO+BPwyEVvwaKHGoZXqg/v2koDNauBUmLcpPQEJ2YEqqVIefRC5Lu6jDlFbj6PNv5BeKczaloqJYvcGEonsFLbgyh5Duo37Ndj3Z4Qq2vqxCvchElRGevSSv+OWKFeiBCJXuv/bxR1Tho1g30oS6wRRDUNKp3U3qFYmI+FXP9ByCTcT6kz7H/ycpSPY3OYBxvB9kBhOJNqNKauZAXBZU0qZbAdLKhxgBjMqWn2Hgby/ZOYtY++UDCVWUJzRkGozT+kU90gCt4AKrSB7y3RgUYtHY5XlWLhH9NOX1HDZL003keWQcpv8Q06VM4hqyYdx0u00Mi8HqKTJKK3o3uDULlTuJxLFD0/r3Y4IFwdR+Nr++AF6VK/9QLu1NpomNL5Mn5SWA0w7NxRjZk35v5MzxXVedgU8KHHOwimOFud29IRunowRAM8COwsamUZqn5Lt9T6LYJTghSKCPbCiH6k1piZHvMydVO+og2pldeScla1fUadlSBeYUY1oGW9fZ6uI0dwf8xWq1E5dQVGxZwBOSg0fQPDSfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680f34d0-ec64-4889-a4fd-08dc148cb8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 23:09:40.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 127EzRsTs9QPqZmjDmuBer1b1472G+r+AN9ZnoEzuMGsxtAjwntUcRLktz5oXHFeo1f/k+wPD0nDsHShc8BtDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-13_10,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401130194
X-Proofpoint-GUID: JWogfmkBdIZvZPk8nv1gjIiE0TEKfR0U
X-Proofpoint-ORIG-GUID: JWogfmkBdIZvZPk8nv1gjIiE0TEKfR0U

DQoNCj4gT24gSmFuIDEzLCAyMDI0LCBhdCA0OjE04oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gU2F0LCAyMDI0LTAxLTEzIGF0IDE2OjEwICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+PiBPbiBKYW4gMTMsIDIwMjQsIGF0
IDEwOjA54oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4g
DQo+Pj4+IFNvbGFyaXMgMTEgaXMga25vd24gdG8gc2VuZCBDT01QT1VORHMgdGhhdCBhcmUgdG9v
IGxhcmdlDQo+Pj4+IGR1cmluZyBtb3VudCwgYnV0IHRoZSByZXN0IG9mIHRoZSB0aW1lIHRoZXNl
IHRocmVlIGNsaWVudA0KPj4+PiBpbXBsZW1lbnRhdGlvbnMgYXJlIG5vdCBrbm93biB0byBzZW5k
IGxhcmdlIENPTVBPVU5Ecy4NCj4+PiBBY3R1YWxseSB0aGUgRnJlZUJTRCBjbGllbnQgaXMgdGhl
IHNhbWUgYXMgU29sYXJpcywgaW4gdGhhdCBpdCBkb2VzIHRoZQ0KPj4+IGVudGlyZSBtb3VudCBw
YXRoIGluIG9uZSBjb21wb3VuZC4gSWYgeW91IHdlcmUgdG8gYXR0ZW1wdCBhIG1vdW50DQo+Pj4g
d2l0aCBtb3JlIHRoYW4gNDggY29tcG9uZW50cywgaXQgd291bGQgZXhjZWVkIDUwIG9wcyBpbiB0
aGUgY29tcG91bmQuDQo+Pj4gSSBkb24ndCB0aGluayBpdCBjYW4gZXhjZWVkIDUwIG9wcyBhbnkg
b3RoZXIgd2F5Lg0KPj4gDQo+PiBJJ2QgbGlrZSB0byBzZWUgdGhlIHJhdyBwYWNrZXQgY2FwdHVy
ZXMgdG8gY29uZmlybSB0aGF0IG91cg0KPj4gc3BlY3VsYXRpb24gYWJvdXQgdGhlIHByb2JsZW0g
aXMgaW5kZWVkIGNvcnJlY3QuIFNpbmNlIHRoaXMNCj4+IGxpbWl0IGlzIGhpdCBvbmx5IHdoZW4g
bW91bnRpbmcgKGFuZCBub3QgYXQgYWxsIGJ5IExpbnV4DQo+PiBjbGllbnRzKSwgSSBkb24ndCB5
ZXQgc2VlIGhvdyB0aGF0IHdvdWxkICJtYWtlIE5GU0Qgc2xvdyIuDQo+IA0KPiBJdCBzZWVtcyBx
dWl0ZSBwbGF1c2libGUgdGhhdCBrZWVwaW5nIHRoZSBtYXggbG93IGNhdXNlcyB0aGUgY2xpZW50
IHRvDQo+IGhhdmUgdG8gZG8gYSBkZWVwIHBhdGh3YWxrIHVzaW5nIG11bHRpcGxlIFJQQ3MgaW5z
dGVhZCBvZiBvbmUuIFRoYXQNCj4gc2VlbXMgbGlrZSBpdCBjb3VsZCBoYXZlIHBlcmZvcm1hbmNl
IGltcGxpY2F0aW9ucy4NCg0KVGhhdCdzIGEgbG90IG9mICJtaWdodHMiIGFuZCAiY291bGRzLiIg
Tm90IHNheWluZyB5b3UncmUNCndyb25nLCBidXQgdGhpcyBuZWVkcyBzb21lIGV2aWRlbnRpYXJ5
IGJhY2t1cC4NCg0KTm8gb25lIGhhcyB5ZXQgZGVtb25zdHJhdGVkIGhvdyB0aGlzIGxpbWl0IGRp
cmVjdGx5IGltcGFjdHMNCnBlcmNlaXZlZCBORlMgc2VydmVyIHBlcmZvcm1hbmNlIGluIHRoaXMg
Y2FzZS4gVGhlcmUgaGFzDQpiZWVuIG9ubHkgc3BlY3VsYXRpb24gYWJvdXQgd2hhdCB0aGUgY2xp
ZW50cyBhcmUgZG9pbmcgYW5kDQpob3cgbXVjaCBicmVha2luZyB1cCByb3VuZCB0cmlwcyB3b3Vs
ZCBzbG93IHRoZW0gZG93bi4NCg0KQWdhaW4sIGlmIHBhdGggd2Fsa2luZyBpcyBoYXBwZW5pbmcg
b25seSBhdCBtb3VudCB0aW1lLCBJDQpkb24ndCB1bmRlcnN0YW5kIHdoeSBpdCB3b3VsZCBoYXZl
IC9hbnkvIHdvcmtsb2FkDQpwZXJmb3JtYW5jZSBpbXBhY3QgdG8gZG8gaXQgaW4gbXVsdGlwbGUg
c3RlcHMgdmVyc3VzIG9uZS4NCkRvIHlvdT8gQSBsZW5ndGh5IHBhdGggd2FsayBkdXJpbmcgbW91
bnQgaXMgbm90IGluIHRoZQ0KcGVyZm9ybWFuY2UgcGF0aC4NCg0KVGhhdCdzIG15IG1haW4gY29u
Y2VybiwgYW5kIGl0J3Mgc3BlY2lmaWMgdG8gdGhpcyBwcm9ibGVtDQpyZXBvcnQuIEl0J3Mgbm90
IGEgY29uY2VybiBhYm91dCB0aGUgYWN0dWFsIHZhbHVlIG9mIE5GU0Qncw0KbWF4LW9wcywgbGFy
Z2Ugb3Igc21hbGwuDQoNCkxldCdzIHNlZSBwYWNrZXQgY2FwdHVyZXMgYW5kIHBlcmZvcm1hbmNl
IG51bWJlcnMgYmVmb3JlDQptYWtpbmcgY29kZSBjaGFuZ2VzLCBwbGVhc2U/IEkgZG9uJ3QgdGhp
bmsgdGhhdCdzIGFuDQp1bnJlYXNvbmFibGUgcmVxdWVzdC4gTXkgZ3Vlc3MgaXMgdGhlcmUgaXMg
c29tZSAoYm9ndXMpDQplcnJvciBoYW5kbGluZyBsb2dpYyB0aGF0IGlzIGd1bW1pbmcgdXAgdGhl
IHdvcmtzIHRoYXQgaXMNCnNpZGUtc3RlcHBlZCB3aGVuIG1heC1vcHMgaXMgbGFyZ2UgZW5vdWdo
IHRvIGhhbmRsZSB0aGVzZQ0KcmVxdWVzdHMgaW4gb25lIENPTVBPVU5ELg0KDQoNCj4gSSBkb24n
dCByZWFsbHkgc2VlIHRoZSB2YWx1ZSBpbiBsaW1pdGluZyB0aGUgbnVtYmVyIG9mDQo+IG9wcyBw
ZXIgY29tcG91bmQuIEFyZSB3ZSByZWFsbHkgYW55IGJldHRlciBvZmYgaGF2aW5nIHRoZSBjbGll
bnQgYnJlYWsNCj4gdGhvc2UgdXAgaW50byBtdWx0aXBsZSByb3VuZCB0cmlwcz8NCg0KWWVzLCBj
bGllbnRzIGFyZSBiZXR0ZXIgb2ZmIGhhbmRsaW5nIHRoaXMgcHJvcGVybHkuDQoNCg0KPiBXaHk/
DQoNCg0KQ2xpZW50cyBkb24ndCBoYXZlIGFueSBjb250cm9sIG92ZXIgdGhlIG1heC1vcHMgbGlt
aXQgdGhhdA0KYSBzZXJ2ZXIgcGxhY2VzIG9uIGEgc2Vzc2lvbi4gVGhleSByZWFsbHkgY2Fubm90
IGRlcGVuZCBvbg0KaXQgYmVpbmcgbGFyZ2UuDQoNCkluIGZhY3QsIHNlcnZlcnMgdGhhdCBhcmUg
cmVzb3VyY2UtY29uc3RyYWluZWQgYXJlDQpwZXJtaXR0ZWQgdG8gcmVkdWNlIG1heC1vcHMgYW5k
IHRoZSBtYXhpbXVtIHNlc3Npb24gc2xvdA0KY291bnQgKENCX1JFQ0FMTF9TTE9UIGlzIG9uZSBt
ZWNoYW5pc20gdG8gZG8gdGhpcykuIFRoYXQNCmlzIHRvdGFsbHkgZXhwZWN0ZWQgYW5kIHZhbGlk
IHNlcnZlciBiZWhhdmlvci4gKE5vLCBORlNEDQpkb2VzIG5vdCBkbyB0aGlzIGN1cnJlbnRseSwg
YnV0IHRoZSBwcm90b2NvbCBhbGxvd3MgaXQpLg0KDQpGaXggdGhlIGNsaWVudHMgb25jZSwgYW5k
IHRoZXkgd2lsbCBiZSBhYmxlIHRvIGhhbmRsZSBhbGwNCnRoZXNlIHNjZW5hcmlvcyB0cmFuc3Bh
cmVudGx5IGFuZCBlZmZpY2llbnRseSBhZ2FpbnN0IGFueQ0Kc2VydmVyLCBvbGQgb3IgbmV3Lg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

