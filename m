Return-Path: <linux-nfs+bounces-1306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2383AB37
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30131293DDB
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA177F3E;
	Wed, 24 Jan 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owrklBrd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PCHcTrQh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1A77F35;
	Wed, 24 Jan 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104527; cv=fail; b=CJqvqpH5IKJpfA5N+XSLQ9qYdPaooDm7ZE32XDnfyzYEx0sV+WARae1I545nz6TzFwY9sccVW586wGyOQzUDQUDCuQSO+2IwZqI6/bcRXMevkt1tQKnMK3iYukyVUnFIp4yy2JyPEXlg9H1AErXCCWyTtSb4beNdGFJ1n2tX24Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104527; c=relaxed/simple;
	bh=QLmqNpWdpPrIAvu7c3TYxs1TE9SwC6v1XzVsvoRVDac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDOQgsXnKaFKbOFisNv0nQccaGznldU5e1vFDw40SceXsVQVWUKdabP9bS5qb1/tiHRLW5YyWC3j52IA0d2qT0p2hebkHImww1Y/ucUdX4/PBUwmG44KdCyLR4iuJ4eYYFGBKVcykqkJHU8tuIFEdqcylO9qVbv++nFAr5ttTTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owrklBrd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PCHcTrQh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OCxWrs023552;
	Wed, 24 Jan 2024 13:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QLmqNpWdpPrIAvu7c3TYxs1TE9SwC6v1XzVsvoRVDac=;
 b=owrklBrd7GsuWUQjmjBkg8Wj2Y040Vq6vv4ZC9aLjxvSenDWfnvikyGw1G6W+Tjy/IKc
 uvA914pwHmdHQRjndulQCIFyfcMxtQXtVUnhJcvJW+QGhPC5XitsIWk8ITrUYMt0CV0e
 FxxcmkEsceEAq3sv6s45f0AGSbpRnbTk5mjecGdJCvkhNXD8Cw15JRRV/YD9P5U2KLL/
 X3IUKNgg2eVeZM8NEPUolNgEZGSgr1XXmyrr83cQHGjewGH0bQ6NLtpXTksJJ1iIenAs
 XVy8rflA1NarGNTItoPGk6+sJi9t1Iaw3WMhq1mlcvD9dKq9rSvklEI35RNycQAxz7Xs vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ac3jq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 13:55:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OD5EoH029575;
	Wed, 24 Jan 2024 13:55:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372phty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 13:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+hbLDv5tLQs6BaX7XQxbQeSjr1Xxk4brdg97MGJbHqLITaetdkCTqVBZXtwpN3cmQ2l+kXGTInVPup+e8/eWWdUQG6l2UjXbHwWXod5tm6+uf1/oftK5vJ6w+AJQc0OSxmhMzhK9U8DRpevDnHLRdAN32R7xcba/OYUALnN3vpaZEs1KDukuHg87hGI5vySVdJ9ZyH5G3AF0zVc07j5frpI1oYwXhvuRJnGaBcI55iYkB7IHxRkQen2Z5tBdSmpnfYjaKo9ZqOiR75y1kd7zLROKvFERYyFRQ9zhJX7YiImhO3c6jhdkiVflGrdhHuqH4BgdXhHTnZCpLnLdWSAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLmqNpWdpPrIAvu7c3TYxs1TE9SwC6v1XzVsvoRVDac=;
 b=YFDDaUWmMC/HwxO5NazUb1tAkVzgyXfBDkxbIumbMmPoMG1SkWJxTJXWwUyaZ6JoY5ieKbDYb1HLsAQy20TxxJYJ4RbN9BqMw1CJhPDY8QtmZFFPwlYa1AjoxX3j0ahRPv4KL5FGwabTAUcIcTz1BWuT8iUl8ofFKz2uTWtY0by6tzov+V6H3mL8pRuSEbuY0/shtklT12PTf3NPSqgU34+6PyLlRJmEtk/4KuvRl9Tq+Pdt5oVuf/4idk0qxLv7Bmh9Qr7CDQUyE/mLZB/ap96Xhjudly1LbULJ4SUju0MUn9uWFOgRLSqFYWbfMisvs0Z5BwW9r1rWrtYYDdJs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLmqNpWdpPrIAvu7c3TYxs1TE9SwC6v1XzVsvoRVDac=;
 b=PCHcTrQhHR4BnIvIPQqcjGLkQ/ludgcPjygdSSD40vJu3bgxsOoJVAwUT7eI8mxun4JxzJCT02wKBtDNhIHjbpBPtOoMLd/PMS3T+7rQ6UXHWZe2URoU4EnemNg8wdUjZ7WB/oVgs3MfBznBJ/x9dpGO2VglXqFiQd2AyJE936c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 13:55:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:55:14 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Neil Brown <neilb@suse.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Thread-Topic: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Thread-Index: 
 AQHaS8bpZ9RzO76t8E+mXe8FqSN12LDl2fGAgACEPYCAABdWAIAAuIYAgAAV2ICAACKWgIAAEuAAgAFFH4CAABm8AIAAKhqA
Date: Wed, 24 Jan 2024 13:55:14 +0000
Message-ID: <917EC07C-C9D9-4CF2-9ACB-DCA2676DFF67@oracle.com>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
 <Za7zHvPJdei/vWm4@tissot.1015granger.net> <Za-N6BxOMXTGyxmW@lore-desk>
 <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>
 <Za-9P0NjlIsc1PcE@lore-desk>
 <3f035d3bc494ec03b83ae237e407c42f2ddc4c53.camel@kernel.org>
 <ZbDdzwvP6-O2zosC@lore-desk>
 <8fabd83caa0d44369853a4040a89c069f9b0f935.camel@kernel.org>
In-Reply-To: <8fabd83caa0d44369853a4040a89c069f9b0f935.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7338:EE_
x-ms-office365-filtering-correlation-id: 239c281b-0326-4a26-bbb4-08dc1ce416fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ny4d6RArO0BSd6/2QDgkFQRZ0IT3iDYPCUoXNb8ZMFOcDlMlZRvi7oWW57+KH1EBBmgsXC7q5vKC931xuhQpsdb0N+EE9zA9bdJrAQWSwv+za7/9FICL57IcoKUKV8nyQG4F04F+P9s5zO8KZWOSw3gWZlF7+L/CjoOSddFtOlIaYzaIgrHUUnmJVp4S6x4YO0aFylydVPInVdMkNuPEvAlK+blTXShPVI0mVhvpfU3X1mB+icjlzocowzT5ckuEpbDtjyy7OX51pcVAlNlP7wefpj4MAF+FVyABqzR1TXWpSm65S/+5CR527p4AUyTVkmW1U7GSjgnUcFdV++jPWkI5MfYaB9jVjyT9XHPd0NOYIRxZsGtcHwsfghbPYmR55nZCBPARcsLveaI2JP1SySljkG4wGJkX2MJYkBDDTwxAHS/20rDVaQHIU3BTUYpHIENX0aRfEfsxS9U/WDcAl1C9qZoRwBSRw9voRVbw4XPsSECrjNz9n46aSQHaB3uroWPrnT+KHVtTUA8WacsovPDs/VJ9MPJv9poAyO03o1TmeshcDdcNJXbR7FSo3Dfzn4K/d633bldrmJLxbs4wG1kmk19nQtrDPGyDfvXLb79beIj0BD3H9rJCOzD5EfKyhT36F8RBvdx9MFAajP+HuQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(53546011)(316002)(76116006)(2616005)(64756008)(66446008)(66476007)(66556008)(54906003)(91956017)(66946007)(110136005)(5660300002)(6512007)(26005)(478600001)(71200400001)(6486002)(38070700009)(36756003)(2906002)(41300700001)(38100700002)(122000001)(86362001)(8936002)(8676002)(66899024)(4326008)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUxWWmRBOEhoMFRMeUFJMFFWRUVzZ3licnpkWm5rNjhUc1MzaGNtOFdKSi8r?=
 =?utf-8?B?ZmdiRHd0Tm5tQXJUdUsvV2F1TUFZQm83NWtveFQyNTdrWDJlVTRhSmpxV3k1?=
 =?utf-8?B?MTZBUEp6N3oxNFZUa05CMGhkK1U0aUFtaVZ3VlorZjdURC96L1dUWnZSVHlX?=
 =?utf-8?B?S1VoVmhYTUpnV2p1K0tuYU9IVFVLQkN1VDZnM3VxU0ZiSFY2SWtndHNYeVJK?=
 =?utf-8?B?ODY0c01tR1daUml3LzJVOTBkQUorQVAvSVBsUE84by9UOFVXTjR5cVBER00x?=
 =?utf-8?B?TzRYVmFjWDlEdWExdkZHazZXZm5IN3J3dzNFemY4cjBuSzErdVRHbmUxQU11?=
 =?utf-8?B?NUg1Q2F4dzN4dkFiZGM3SUpKRUpyVlpCL09SOGVQa0VrMXIzalFPTHBqTHly?=
 =?utf-8?B?K00rYy9OaHBZNVhNV2tNTE1ueElrM0ZaR0VRakFMd1BDTXpLUkRhTDVDTlNm?=
 =?utf-8?B?RUM1N1FhNGVIRDFpRHNyeUFRTzc1TnJ2UnFxaHVtNzc5MHYxbkdvY1lNRHZN?=
 =?utf-8?B?dEoxUFFRckZJUyt0SC9WeXJlUmpMeXlaTzFJMXJLdGNZZTdlVndkaGJNd1Qz?=
 =?utf-8?B?NXBZeWJuVVIrRU9WRno4dDVodzNrSGFmQVhHSjVXOXVlVjJmK0ZQeUk5U1k3?=
 =?utf-8?B?SDNBTzNRcDQ4TlM2WmVrZFBDN1ptaXZNd29mTHF4VFpZZG53ZWpKcGY3SGYy?=
 =?utf-8?B?TzlJNWllWGo4L1Bab25vTzBxbkVWQ0hDU0RZZkVUZVQvZ3h2Q2wyaGROdnlT?=
 =?utf-8?B?UEl0Y3BrandvNG0vcjAyWFhaWXlmS3AwZnFtUklCbjlzbHNsYldWVWRldXIr?=
 =?utf-8?B?Z3BkNW1NSk0wY1dFWTVyYjFsYlBOeE81bTU3RmJUYzR2WmJoMlhwbDUrTnJj?=
 =?utf-8?B?eFVOaDI5RlNKcTVHOHE0QkRBaUFXSjZSaEVlUUhDMG9zbWRvak1rMytpM2d3?=
 =?utf-8?B?czRqaG9DN1I2VkJXaU9mbDYrRW1QdWZ4bzhEaEJqVTFzYWVDNGhISFZrZkdz?=
 =?utf-8?B?YTd1bTlBek5uU2xVcnc4VzJOVlJxZTRaTkd5RWhQamw2MjBHaERIL2RYU1h0?=
 =?utf-8?B?R3grZGdnclZBelluM3NlY3pRdm9UMVZ6YlhtNXF3dmt6OXIvc05hZ3pEeHE0?=
 =?utf-8?B?OXYzRjBkMjZydExWMnI5RENNQkpxa1M1VjFGNmNWUHNLUlNXMWM1RWp6NkpC?=
 =?utf-8?B?TFJTRU1JNVFxN3BTQ01YSmVWREE5c2pBclRQWFFxRG51ZUNjNzM0VXlCUjhm?=
 =?utf-8?B?RmZwL2Y5Q2hhcy9HUVh3Y3FMa2M5dXA3eEFPSC9tTWZmL1AxaEdyWXpFSyto?=
 =?utf-8?B?cGFQYy9jYmFzSFd3YjZvODZ1ZnFwUU5pVExXL1YzUUN4aXFqcXdvN1ZMM2w4?=
 =?utf-8?B?VS9qdEdSaFFHYUhWaVFIM0tKSitHcEFNY0dpeUp2MUZKMWtUb3lvRzR2SURE?=
 =?utf-8?B?ejZTNkZKMnc3SjI3NTZUbjFaY2hTZ0QzSFNZU1VTNzNGYU9iOVJOU1hWZ0k3?=
 =?utf-8?B?UlRUa3VXUzZPUDNVaFVjRmQrTkRubjlYWXlWd1ZleTFFVTFiSVZXUUZoM2ha?=
 =?utf-8?B?dnRSOEFlSzA2azRJZEcrS0xQSDBZM2tiUTVsNmgwanRIa25UUGQyK2pFS002?=
 =?utf-8?B?dG5FaHN1NUhsbHBxSUtTREdLdkF6YjkwZEk2MFFOWC9RT3YxRWJDdjhzdmZs?=
 =?utf-8?B?SzFpN2QzZFh4QnJBS05JNmwycmtSSlJ3WHlwRUpseWNZTE5BQ05pSEtpVXNU?=
 =?utf-8?B?andMOHhsbmk3OHh5S2FiM2FkN1UzY2hYTHRYVkdpN1lYaHg3NUZvbElhNGtz?=
 =?utf-8?B?Z0dQMVQ5b2tLdzRnYVczY1FkQXlId0ZoNXJRV0hoc3drRkZWZkxSejU0K0Qw?=
 =?utf-8?B?ZENrWmpPWUNnUFBzMlZoRjRuUnlERHpZdkJiYXJqamVzM1h3dU5ydUxydldB?=
 =?utf-8?B?M204Z010Si92c1RGTVZmT1N0UzdwMy9hMncvMkl6VEYwTjFpL3lpdDNJWVdK?=
 =?utf-8?B?Mk1XTVJGaFdRc0tsUHN5QTJodmJOd1RtMFpRbzlmb2QyRnpTUXZLRS9EcXJ5?=
 =?utf-8?B?aWtSUTh5dllLSW1PaG1XeEhXRDFEdldTNFAwVmZLMTN3Sng1SmNLRlY4a0c4?=
 =?utf-8?B?cDU0Qnk0Y0lYQit5aUdzWkx0NVNtbW5UNk44dk1iWm5kVEpnU2hQZkRlck02?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E062C4003F4849B43E99FB409C4551@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YQq0UT5PS+ki/BkKDgxjarIkBx0J44I3/B6yglkXwMtJAlTN5PKeLSkBdcsnh3t/DeCpzzmGFnbmbFXoE956Xm7EjRBkJ1wfOK9foJEtAO9B59ZWonui55qfBh/JI2T1R26N5qWh29RU2lAtyvKo5vV7qBH/mHL9sSEXjEA8exsvQokS/HnHosWl2PBicwSsATcBNM3cqNDTHK9uAI/ax5Lup2v/5taT8uVkY2dFDYVKkWpnze+31SwUNiE7x8UWx1LhcS4KnPPdeYolTS8RuC6/5mGPYUgd8FJT3I+lOS8227iKvFJTZkgf66DSJmsda27ey9/TVTzNKtyTZ/JXd/fxLf40lB1HyK5/HinpNeCMjiX2bHUjqr+FeUaKNgcDSIAq5MLgBr3BWucY/5RgNb49vm1do+uMEQz1PyCoFm/hk/bFIks1T5/i/pUcniN5ysKHx4BrIfMpdhDd5kli18lpeqUkhkUkZnst4D+ERo4UWEaHo+Y4pLn3akiA+1cxGM5DHjeIlO5E6qCseoQWoi0368LPUI8WPgO14kEIWTvJM2sUg9DiCx/lqflwF2NEmdyjwUoLuneyu3xREHV1hgPqJeCXJYd2UpMIbtBJGXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239c281b-0326-4a26-bbb4-08dc1ce416fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 13:55:14.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WCOhxzprgFkh2HHqvqQtQhbCq0Re+0t+UInLi+3Uf39CJkI2JkW4V6iwnOL0nK75iji5em9Wg5+dEaQkaBhMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=891 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240100
X-Proofpoint-GUID: dySLLdg9IzKJxcHs6AypR5KyfEzNie-p
X-Proofpoint-ORIG-GUID: dySLLdg9IzKJxcHs6AypR5KyfEzNie-p

DQoNCj4gT24gSmFuIDI0LCAyMDI0LCBhdCA2OjI04oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMDI0LTAxLTI0IGF0IDEwOjUyICsw
MTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0KPj4gWy4uLl0NCj4+PiANCj4+PiBUaGF0J3Mg
YSBncmVhdCBxdWVzdGlvbi4gV2UgZG8gbmVlZCB0byBwcm9wZXJseSBzdXBwb3J0IHRoZSAtSCBv
cHRpb24gdG8NCj4+PiBycGMubmZzZC4gV2hhdCB3ZSBkbyB0b2RheSBpcyBsb29rIHVwIHRoZSBo
b3N0bmFtZSBvciBhZGRyZXNzIHVzaW5nDQo+Pj4gZ2V0YWRkcmluZm8sIGFuZCB0aGVuIG9wZW4g
YSBsaXN0ZW5pbmcgc29ja2V0IGZvciB0aGF0IGFkZHJlc3MgYW5kIHRoZW4NCj4+PiBwYXNzIHRo
YXQgZmQgZG93biB0byB0aGUga2VybmVsLCB3aGljaCBJIHRoaW5rIHRoZW4gdGFrZXMgdGhlIHNv
Y2tldCBhbmQNCj4+PiBzdGlja3MgaXQgb24gc3ZfcGVybXNvY2tzLg0KPj4+IA0KPj4+IEFsbCBv
ZiB0aGF0IHNlZW1zIGEgYml0IGtsdW5reS4gSWRlYWxseSwgSSdkIHNheSB0aGUgYmVzdCB0aGlu
ZyB3b3VsZCBiZQ0KPj4+IHRvIGFsbG93IHVzZXJsYW5kIHRvIHBhc3MgdGhlIHNvY2thZGRyIHdl
IGxvb2sgdXAgZGlyZWN0bHkgdmlhIG5ldGxpbmssDQo+Pj4gYW5kIHRoZW4gbGV0IHRoZSBrZXJu
ZWwgb3BlbiB0aGUgc29ja2V0LiBUaGF0IHdpbGwgcHJvYmFibHkgbWVhbg0KPj4+IHJlZmFjdG9y
aW5nIHNvbWUgb2YgdGhlIHN2Y194cHJ0X2NyZWF0ZSBtYWNoaW5lcnkgdG8gdGFrZSBhIHNvY2th
ZGRyLA0KPj4+IGJ1dCBJIGRvbid0IHRoaW5rIGl0IGxvb2tzIHRvbyBoYXJkIHRvIGRvLg0KPj4g
DQo+PiBEbyB3ZSBhbHJlYWR5IGhhdmUgYSBzcGVjaWZpYyB1c2UgY2FzZSBmb3IgaXQ/IEkgdGhp
bmsgd2UgY2FuIGV2ZW4gYWRkIGl0DQo+PiBsYXRlciB3aGVuIHdlIGhhdmUgYSBkZWZpbmVkIHVz
ZSBjYXNlIGZvciBpdCBvbiB0b3Agb2YgdGhlIGN1cnJlbnQgc2VyaWVzLg0KPj4gDQo+IA0KPiBZ
ZXM6DQo+IA0KPiBycGMubmZzZCAtSCBtYWtlcyBuZnNkIGxpc3RlbiBvbiBhIHBhcnRpY3VsYXIg
YWRkcmVzcyBhbmQgcG9ydC4gQnkNCj4gcGFzc2luZyBkb3duIHRoZSBzb2NrYWRkciBpbnN0ZWFk
IG9mIGFuIGFscmVhZHktb3BlbmVkIHNvY2tldA0KPiBkZXNjcmlwdG9yLCB3ZSBjYW4gYWNoaWV2
ZSB0aGUgZ29hbCB3aXRob3V0IGhhdmluZyB0byBvcGVuIHNvY2tldHMgaW4NCj4gdXNlcmxhbmQu
DQoNClRlYXJpbmcgZG93biBhIGxpc3RlbmVyIHRoYXQgd2FzIGNyZWF0ZWQgdGhhdCB3YXkgd291
bGQgYmUgYQ0KdXNlIGNhc2UgZm9yOg0KDQo+IERvIHdlIGV2ZXIgd2FudC9uZWVkIHRvIHJlbW92
ZSBsaXN0ZW5pbmcgc29ja2V0cz8NCj4gTm9ybWFsIHByYWN0aWNlIHdoZW4gbWFraW5nIGFueSBj
aGFuZ2VzIGlzIHRvIHN0b3AgYW5kIHJlc3RhcnQgd2hlcmUNCj4gInN0b3AiIHJlbW92ZXMgYWxs
IHNvY2tldHMsIHVuZXhwb3J0cyBhbGwgZmlsZXN5c3RlbXMsIGRpc2FibGVzIGFsbA0KPiB2ZXJz
aW9ucy4NCg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

