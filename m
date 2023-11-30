Return-Path: <linux-nfs+bounces-203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34697FF0B0
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF50281B34
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66E3C06D;
	Thu, 30 Nov 2023 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfEKZF8a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UmC4kh6w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AADB194;
	Thu, 30 Nov 2023 05:50:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnQjn022710;
	Thu, 30 Nov 2023 13:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/WQJHvwIvcMOC7EeZu8QsuLxTH3iPCA2nGOyPAe+AVg=;
 b=jfEKZF8a8MiZk9TWUz5ak5snnMjWLoUUbjULd0h3zftWKWP2u5r9QCjI5c+5tIKSmFPx
 AAIkqKVnTLf/Bp2gUYQjMcPVbOQRMcNIF5aU4r3RCbFZ9NHmDfqG06BTOZsHUhkdrxJW
 4ilLR6JnF5Ie+FQjVvbt6R9U30Ea/ZDfSmEaSu8+bZDpVK7dV/P/iqRyuUS0sPLyMyFd
 5Dh2o+w/9Hp9C4VFVm5uQc2dm3yR9Y76KDCnkoRkMf2C1d0hvyqXF3Og/RcTTIaDs+rA
 uV6wzy3PosKuatX9C9T02fks1QNE9Nphe+qcfnT2a0xHO02euSPeczXvlyvdKj7OFWQS pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upu4qg25p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:49:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDFjTJ026975;
	Thu, 30 Nov 2023 13:49:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cgkxmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc4QdpFfnH42uCaSQ9QPHcjHZk23qycadTlaBmZtCK5tj2oa30+OZiPZTMRsU29sbuCDsXNbVaeZMtgt+hpz/eQxlNjKoiymxg8ASMy3fwlI5zFPz0wXtrfgt9fhsqdxrISCjSRVXn3zirg+46aHOm9JZ2BbWdvjURoGtqYlILO3UZEPiAu+23j/8aKVgcbQLB3i4XoEimAgePfvXF2w3mpodnd4WVPDYcRmVLbCVmBGRlV2m0RGEmCl3GubinhNC9ep4SkC3EVSwPe1xsng4Z/Is8+1hkpW3ND7nr1zbdJks7/vQ2Ts+nXvf2Eylceip7We8BbOA27fET3ipaDMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WQJHvwIvcMOC7EeZu8QsuLxTH3iPCA2nGOyPAe+AVg=;
 b=WZ535T+1K/esQ05URi2X0TQ7oNW4BD4qH7HTrm87KQ6HxbRItS58UAJJGsxjdxKqmvghgebC3XC7KJ8zGUiBJ7uUALkAvUHQK/FWmtFZYRVgvRDMKQ2HWUHRX8eHscJrNpYLRktRl8aKmMtIWK6UZPOVwcP+0xoEyafhFRZDNdu6dAyym8ZXfw27ojB81wu/sCJ80aqLY1CrxmlUYlK7MmWvFPLLme19R3pmiXNYDa1qJkvgJQyve8PcMC6d+dQODIpyYPp0vvawDhsB64ijVN6GqKsiwkqqeBU0PCLbOsKmbkKM3+cQdmZNnd7IarpO/eA+pTLUbi/o+CgoNus8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WQJHvwIvcMOC7EeZu8QsuLxTH3iPCA2nGOyPAe+AVg=;
 b=UmC4kh6wBnSPBEk6j8TG4Xb2fZgwt4hwtGgPaUg+n2FRsOpRLMiezgGz68UjK/tD+/bEzXnb4wnkVhss4KAOlqx+Grychu01NC7KZxnusyC+0wMUqdyulbQQcP2bqqK8ky47gDo+FAopluFw1lcBHBfxLUdWAixcwpQNCvzvpl4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6273.namprd10.prod.outlook.com (2603:10b6:510:213::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 13:49:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 13:49:52 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] nfsd fixes for 6.5.y
Thread-Topic: [PATCH 0/8] nfsd fixes for 6.5.y
Thread-Index: AQHaIkYyL/0SS5hNA0elwk6nU8iyCbCQSeCAgAKS7oCAAAbJAA==
Date: Thu, 30 Nov 2023 13:49:52 +0000
Message-ID: <FD116F8B-DCB3-42C3-9476-5EF6C9B824D3@oracle.com>
References: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
 <3C2A1F40-C0F3-412E-87ED-66AC1A2CA0F4@oracle.com>
 <2023113013-fanning-esophagus-787f@gregkh>
In-Reply-To: <2023113013-fanning-esophagus-787f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6273:EE_
x-ms-office365-filtering-correlation-id: 09413c2a-2e3a-4fe9-256f-08dbf1ab3ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hfJ0/wYMJgyfcPsE5A+Aid8r4Xduon8/60bhGPkiZzLqwVfaPmXTYBplkZ85tANlCD8OWIOUeWzjG0U/rM8RRGhamMXQZQvaE3wTEzwJGReUJTDaiOfQ3PZt2PCqxKUzfqs59TR/w6Hzvnem9/O1IMoNox3XfMsev5mthRTwNLh0qpacasdHI94hYsbVfh1sSISSJUWCyuPebPlrDeQG/voOzbRSGoQhCNMgmQNZCegPYhbjyxRboH0nNTosH8KMNiqSmW+WQ7RkQx5VWLYSGxtYYYhN6W0tex+h9hVR75+KKvPPF68S/joEpuaaaQKagXAs+2F6ImySk4NXpZwVSyDMlyPs0Y/EyGRpe7R5jUl7DA30II4jtqjxI4GLhXsvrkVQ7lpYEuMcy4Div7P7QF1RKEdC9T6GAUr2T21cow7AASptgcpcHKaCSlPlLHS5V5XC4oqLkZ5sltnoO815p5Mp7qOZ1adoIT91WPvKWofYK7QCFsWg8nL8Yf4J7oB9V/8EN6jkUsvJ5FVA2P+sOu7OIr33S6y8hbDsYmqNL2tRjyitwpt2/xQ+sc/Eh40TpFI0S9bNfZSvNNFVpx4Xh0qvhqaEKb2hnFgrkoGlo7C0Ayzl5/SG22MYT53erKrLKNP7tWe2ElGf1ZVyrxQQPQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(66899024)(76116006)(66946007)(91956017)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(71200400001)(38100700002)(36756003)(33656002)(86362001)(122000001)(26005)(6506007)(2616005)(6512007)(53546011)(2906002)(316002)(478600001)(6486002)(5660300002)(8676002)(4326008)(41300700001)(4744005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bzh4dHlIQ3JBQlVrVk1SMm5VUDc1SmI0SFlBQVJYRkhONXFrdm9WRVRxNlZ5?=
 =?utf-8?B?aWcxVHdoemNRRVNnQ1I5Q3BEWDROLzBsYTdJNDYzVHNZVldOZGhRMUNnVmts?=
 =?utf-8?B?VElGZE1pMWpodG4wWEk0cXl0d3BDUjI1bmZCaU4rc1FYUWhRZERPSFN1U0Rq?=
 =?utf-8?B?N3dFRUEycW9wN3pweWoxZDk4VUU1SWZ6RkM4TFF4MnFzSGhHMld6THdtby9v?=
 =?utf-8?B?LzhzWStMRVBWRkFnOXZ3Rjlmc1JMbTh3Smd1bEFkblNRUDVtWWh0UGQ1bkVl?=
 =?utf-8?B?OTc1c0RORUJjU2lQVmtsREdLYjgvckM1TmtQOTNJWVptNXBESmozSGUzVlMv?=
 =?utf-8?B?dldxb2hwSWZWUGpHd1pEdVZvam14RXlWZkttdU43NmJtaFFOVm9KSlFETVE2?=
 =?utf-8?B?ZWNPdTFsTkJzcURMclJJNGNSMFlhdlpPVVFJMVJGZWhFZFRwN1BOOWJTWExW?=
 =?utf-8?B?MkdnSFJuSEU2MlgveXBCVGtUZGF0aGpscEtVSGxocXhDQ2Z5NTdsK1JuYlVC?=
 =?utf-8?B?QktuSFEvOG9Ma0d4aTVDMjZLejg1NnAxV3BpR1JIdHhzSW1Ec21KRnQ5Z2RY?=
 =?utf-8?B?aGhSNE1mdGxRNWxiSkJ5WlhuV0hQSU02emdjSHJIdWpBNlpOUkR1aE9ZOUVP?=
 =?utf-8?B?b0FtUDg0QTlTVTFCajZ1TkxFVUxKaE5EaUo1UFFORVQzYk92dGg2S0hnT0xl?=
 =?utf-8?B?aDhUWDNaK25WWUliRDdJK2NkRXFxWURRNWNIZWdNQWJaNlVZZXQrVmF3bUFU?=
 =?utf-8?B?dXZ3M3M3ZnVvZTZSTGFWMThpN040VGExczVHaFVFMDYydjJwNWM3RSs0bWhY?=
 =?utf-8?B?MmlHUnp1cCtYVzZJQVNCZEF3T1p4M0xIRU9uWVRCV0lzMmFPTUJXdGc1UUgx?=
 =?utf-8?B?STQ4YnRZUWRhUEJCOXlpT0FsN3lZQjRFM0Jqdm9XTnYyS3NkK1pDbXNuZks2?=
 =?utf-8?B?dFpmbEsxZlpNWW4vc0FEdW9tWVlFbHBoRlJ5ZXR6dFUvQ25scTdFejlId1I2?=
 =?utf-8?B?bU95N1VqN1dCNzNNajMxWGFDQ1cxVVpkQXowUnBsRnZlQWtvNWRSTm9zOEcv?=
 =?utf-8?B?RHJEMFFDa2s5MGVpV3pqT3E1ZDNpYXBQd2E3NU5WOXVxV3hEM1BwVnZRT3Nj?=
 =?utf-8?B?b3pkRG1TQXl0WE5MYzRvclV6Uk96ZCtmVjZCRlovVG5aVGIzdDhFSVNybnoy?=
 =?utf-8?B?b04rRDJSd3BCOVUyOWNFODRFY3Z2V2k5SWJ3Tm9aWWxneDc0dk5oYWQ5NlV4?=
 =?utf-8?B?RHVXN2VVSi95NlB5UDh2NDk5NkF4YlRkVVRSQVNxR1pENXBndTc5QURoZlow?=
 =?utf-8?B?a3g4WUl0YkZKaE9HRGJ4Ny9jektLbkpHcUs4NlQ1ZDhCeEtSVHRQT1F4Y0sv?=
 =?utf-8?B?WDhLZ0tJTHBTR0RIMTBCZklodlN0L1hHenptVkZoNFZIOGsxMW5OejZmckEw?=
 =?utf-8?B?MERVcFBOeFVBRWdUZE9ORjl0VzlMQm0rQjBCbHJmREhLbUNzbW5MSHowSWk0?=
 =?utf-8?B?MmpIUXlEUERBVkR2a2t3ak1MOUtrTVpTRithaWxkQlQ4emY3REVoVU5KVWNx?=
 =?utf-8?B?akNHRVY2enA4QUVCWVc1eUFiY2RwdVI5Qm9SSjFCRUhWUE9CVXVzUVNlUHY3?=
 =?utf-8?B?WlNTODZaTG5mTmdZLzZRSXR1UUVpOWJET3JNV3ZvYVVBYnYzMyt3d3NpOWZR?=
 =?utf-8?B?Y0ZRTm1TRlJCSE1rN1V0QkxqZFp0U3hmTTZyOFpQVVYvWVhNKzRBeU4rTU9u?=
 =?utf-8?B?RWNQNjJaZjRaSE5wNUNNRHpqWDNheWtPaGE2QmFKbXZkRXJWVDBydHp3bnBz?=
 =?utf-8?B?MjlnQjdNbE0zTzNOMHhCNFJudXFxUEMzN1AzcktyQndiaXl0aENSM1dvenRX?=
 =?utf-8?B?VUFRdTlZVkdvd2l4dGRmcGFDOSt0RzFTUGM2MnQ4bXpyTjkrRVhZN2xOeHVo?=
 =?utf-8?B?Y1NoMWZGREVDSHhWSHgrN1cyS0kwcXorQ2M5OHUzcTFNdm50UmdaT1o5aXA2?=
 =?utf-8?B?eDRlNUR4RDUyaTk5Sm9KM3l4K1F5RFVtSjFDY01qSnRzSDgwSFA1eE1vVE8r?=
 =?utf-8?B?cE5XblV3ZVMvU3l5c0k2SytUcXdrUTJNU2hyQnJQNTF4b0c0Z0RUMXFJVmNK?=
 =?utf-8?B?WXYzak16a0ZwMXYvb0pzMmt1Z3hrdkw3RGlYeFBtU2c2MTFVcGJYVll0UWVD?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70EC4714205F494D8649A7AAAAB274B0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p1K2mWYPpRPzpcpYsTt8WtjxoC0KLrLqfuCmuTl4HfYlLDR69yg4Rre7z+Pzg128yN1AXUvg9IMsSlcuY4QXQ/vw4J5tylv40Q5cBAqqmnM1/c8vRQCqLCZe1pB0Fw3UXoOiShkqN86i3lCV5m75D3JtYD8Vn7MUsHSltPYbB/mrWzTkxbsvGebC4uGsYDW4oN1rL160wVdIQZnbz9shUYloeY8GZ8fG76eWdx9A5plCcvHVuf0mDC9g+vUTqrGTktSUonEH7TQoqagmY8yArsTki3Yt7LF4l6wGjnTtRsLsvvRHctfFyx0ysuZF0McGruSHmAobl9UVj9V/FUAUJs8KHCgUQ0ygfqnTMLxw97hQYb1t/dER/GC9FaFQT/2CD2gBhnl+20uHl+FYze3ng0XWXLiSeFGq6vz1m264X9L4VUX6ZoHNYthdk4foOgn66K5nMydcWxXASGwx12PvZ6h5+lL2YS4qCLRGQbGFB1grQwtdMgU+1bOoOKkENGliGhR7DXB8SKMIq6C8+CWiQiLc05AOtyPAVzCyYxknuxdVArWkrX7JXPKNYkhsh4tUHahSYHKDlGB6YIPV2xsu2ry6oBuV5N90cD8zAaS9lJY9+7epJdigOdyyDpaRDjl9I6eVtWAyVqSXiFowL8kf8M78BOC0ortJm0c/QQzWxiNgylksiLTsleok3LWoSGoL3uB7FF5kOicS9qtqLOaYIWlT9g2uPDIoXI57GSwaeq/vzaox2NE+HSG4YbPECK6dfdY2MeCPgMpGANa7N22T8vHdN3lg+GMURiiZiz07v3WQAI18k9cNLCHgVpGYeUg8/jeNN4lHQuIUGeeYy9ymhS14P3pxofwcael5J5IwTO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09413c2a-2e3a-4fe9-256f-08dbf1ab3ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 13:49:52.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/GXNznkAl9x/SAohv+hPuDOniDnzCJBRuiT4I5qFRm0OWINMVUZz37PISABIP7uibK1EvqbDyhsGA9K9hFR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=413 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102
X-Proofpoint-GUID: 6OyE_H_TWmt7jNqm84XaU9V9B7r6kxYj
X-Proofpoint-ORIG-GUID: 6OyE_H_TWmt7jNqm84XaU9V9B7r6kxYj

DQoNCj4gT24gTm92IDMwLCAyMDIzLCBhdCA4OjI14oCvQU0sIEdyZWcgS0ggPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTm92IDI4LCAyMDIzIGF0IDEw
OjA3OjExUE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24g
Tm92IDI4LCAyMDIzLCBhdCA0OjU54oCvUE0sIENodWNrIExldmVyIDxjZWxAa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pj4gDQo+Pj4gQmFja3BvcnQgb2YgdXBzdHJlYW0gZml4ZXMgdG8gTkZTRCdzIGR1
cGxpY2F0ZSByZXBseSBjYWNoZS4gVGhlc2UgDQo+Pj4gaGF2ZSBiZWVuIGhhbmQtYXBwbGllZCBh
bmQgdGVzdGVkIHdpdGggdGhlIHNhbWUgcmVwcm9kdWNlciBhcyB3YXMgDQo+Pj4gdXNlZCB0byBj
cmVhdGUgdGhlIHVwc3RyZWFtIGZpeGVzLg0KPj4gDQo+PiBBZnRlciBhcHBseWluZyBwYXRjaGVz
IDEgdGhyb3VnaCA2IGNsZWFubHksIHRoZXNlIGFwcGxpZWQgd2l0aCBmdXp6DQo+PiBhbmQgb2Zm
c2V0IGJ1dCBubyByZWplY3Rpb24gLS0gdGhlIHNhbWUgYXMgdGhlIDYuNi55IHBhdGNoIHNldC4N
Cj4+IFRoZSBjb250ZXh0IGNoYW5nZXMgd2VyZSBkdWUgdG8gTG9yZW56bydzIG5ldyBuZnNkIG5l
dGxpbmsgcHJvdG9jb2wuDQo+IA0KPiA2LjUueSBpcyBub3cgZW5kLW9mLWxpZmUsIHNvcnJ5Lg0K
DQpXaG9vcHMsIHdhcyBpdCBtYXJrZWQgRU9MIGEgZmV3IGRheXMgYWdvPyBJIG1pc3NlZCB0aGF0
Lg0KDQpObyBiaWcgZGVhbCwgSSBqdXN0IHdhbnRlZCB0byBlbnN1cmUgYWxsIHRoZSBzdGFibGUg
a2VybmVscyB3ZXJlIGNvdmVyZWQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

