Return-Path: <linux-nfs+bounces-5521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8D95A0C1
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5556728860C
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055321B253D;
	Wed, 21 Aug 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XWhWKMwj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2116.outbound.protection.outlook.com [40.107.101.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0B1B2528;
	Wed, 21 Aug 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252323; cv=fail; b=cNXTWB6AFXl5KtNANlyOlvpvtsjuFf4hUr2NQAK5lR2YrDwmIcTpS4tdeUNTjsyvLr1B0x3bN+aNqJCoZHxWZXNW3+QQOdcmsqh+pM+WQNC0ZFepWAMA7DilECjUr3xne5uD8KK4Hg+PcDOyHK9gIc2jfBk7WMHNkGihOKNDGHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252323; c=relaxed/simple;
	bh=gzpcIGkReiYjjGDbWFYoutpJnFEJ1PBfgV4ecFiiVNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KAdyT3xZF0TdFgKdul+yMIZFy01b7uHod2qurUu/cwctBBkReCaLdHUxL2iNUAf0968mttn9K5fgZFKdoOqRBV6uuJkCyyy0L+ySnS3QQ3gmiX1ghzpYrikus56pPhM/Z4SrIC9iBrSbkVR+wU6mcoFBwXcWYkWJm805NDbvhkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XWhWKMwj; arc=fail smtp.client-ip=40.107.101.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuNCUTGkylnknQSQ+kKMDq7BAH3k53RDMODRHshk6bCTSBhYo5K26nwWBAB3UHwsy6j91gg49uB0iizjMTHixpMuRGIdfnO+czbp+QeKQflj1uSx6lxBYolFcKsOmroQF2t5/8rTIghfyoJAklpe9yxev5MbP6K3ntGoayVTqanKMY8f/bLn7HfUNLYevh6oRGDBWk8FUaoFMvdlrLdMyRFpjAKqAzeFfj8zF5Ow/TDSvRqAqvcppImBprt10Ihryvl4Rv6BVfpWdI5akhk2z6Kn8o2VsbQB0oZpgPNnVoumpVKXYCvQU+8GwFFNhab85VFknS5uRUI+spuz8O6rFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzpcIGkReiYjjGDbWFYoutpJnFEJ1PBfgV4ecFiiVNw=;
 b=S6x0G5UbGFDZw0oepvx9pjvzfWpMGOfO5ZvKm5H/TXeWa44y3jbjudLETYFlVw0KEKSbWMNXODHQiW0l3o9Z03f+N8hIG4895Qu01+P2gaHFRnySx2elMwYPjkR7R0/WWPzldRMeo1fdQidkJpi6AtHbLWwr3yc3VTK78Nf/wOzLGQPwtZ2qCA7X3ZBwu8nNRdvzaAiyWz0K3cbT67V3H9Ygqkp0SMw8/gAy5jE6zQ92UvEG/io71CCU9w4GtdYYAL71+9+QGQkyziWDv4nIgCFyIu8DbUjU+tly8SI/0jVhH4u3kz/SS8Ce7TO2itbkCWfLHevW3QjT7In22m2YGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzpcIGkReiYjjGDbWFYoutpJnFEJ1PBfgV4ecFiiVNw=;
 b=XWhWKMwj5tTOExAMEwpCbM/Oq6uWXvjBPvckT9SLF0Y9upLPh4a3GG4Q8eOBBf4/I4zcIeGXUZMUZWkW1W3Nr+F44xa/9GZY1ESN0q5Qjk41LNMJc8BPdL0sanuqdcTJ/Iwdu9wuGV8d/KiXmzVpheIzm4pvjCDsmsUbPCR5WLc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5843.namprd13.prod.outlook.com (2603:10b6:510:151::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 21 Aug
 2024 14:58:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:58:37 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, Lance Shelton
	<Lance.Shelton@hammerspace.com>, "jlayton@kernel.org" <jlayton@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Thread-Topic: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Thread-Index: AQHa88P+hf0nGPltEEmWAsZYKG8Xi7IxzaoA
Date: Wed, 21 Aug 2024 14:58:36 +0000
Message-ID: <963d3249b9c9bdc842a835e5c38d00638a6037eb.camel@hammerspace.com>
References: <20240821-nfs-6-11-v1-1-ce61f5fc7587@kernel.org>
In-Reply-To: <20240821-nfs-6-11-v1-1-ce61f5fc7587@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB5843:EE_
x-ms-office365-filtering-correlation-id: ad15c163-1fc9-4fb2-e3ec-08dcc1f1bc45
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1B4aFhwRmg2UGxYMmpUK2Y1QTd3NEt5dnZ5Vm5lSlVOZm01MkpnNE4vS2FC?=
 =?utf-8?B?c2ZmcDFCc0xDcWU3QlhKQzVaWGVNWndQTSsvSXB1ZFZCZlF6TUZPRnBpZ2tG?=
 =?utf-8?B?eW1lLzdaY0tZVDcwUzhPTk1DN25KZEFwN0FvbitXME5ya0V5YVQvdk5MV3pa?=
 =?utf-8?B?VGFQbmk3MGNFeE9GUXA5YjN6YzJ1TisyZWppZEZlSTJ5TmFqOU1GMVhHVGhX?=
 =?utf-8?B?T3AwM3JDY1cySUtTZkVKTzdJaDhQOUpheU5lT0xTV2FKY2N4em1tejRzU3dU?=
 =?utf-8?B?cXI3bmFRMGlNOWh5OTBKeERtWlkwOXVydHhoZHVmNjJMTFg4NEx1am8yUTQ5?=
 =?utf-8?B?cW1kUjd4MTJKQzROMVN5TzJoWDByRy9TSDNWc0czTEdZWVg1aFVhbXBYZW9Q?=
 =?utf-8?B?c2pWNlVmbjh6bkRvK2ZhZjNvM2cwMEhDd3VPK3dFUzFVb0ZjQWtuZ3EyT0pK?=
 =?utf-8?B?QjI1QmV0VlBkTXUrMDFBV2paZGlzbGIzSEZFUDVSOHNjbnhPUG5pbmU4Ujd2?=
 =?utf-8?B?aHlSTTFEVTFFTVNyS0JKTEhsVlRBeERvcWxpVlRxeUJiVHo4aVBpQUljRlNi?=
 =?utf-8?B?MzJ0a3ltbzZPN1VSay9jOFMxNG1BRDFIcEdRTlNobW91NFhPT1hkM1lIQytj?=
 =?utf-8?B?blR3LytTT1VyWStiQ2c1Mm5QQ0VBY3ByL3Q3QjYrTjliNlpyQklHNGpRUzZU?=
 =?utf-8?B?azhnTU1COFl2VEFvOHJ2OHJEUDZ6ZUltQnV0SmxzVjR4WVVFYlE5MDhTY2RS?=
 =?utf-8?B?L0tzN1VVU3hHUzZUZkQxZWF0cURqMjhHVXhQbVlZUWtWcm9WWjdCQU4wNm5R?=
 =?utf-8?B?T1E0UDZocWFtVE83bkt2U0dNY1hWVmlXWmhsYllXb3dHQnFMNmxFRjk1cGtC?=
 =?utf-8?B?UkxadVloeHdFOTRNa0RkU0pmczVnVTJRRmsxbnFxNThpN3lXcW93VzYrcnh6?=
 =?utf-8?B?TENZdUhEN2lnWUR3aG9RZHY0bmhYaVluSUxuc05CQy9IS3ZIN0tvMkdYc09X?=
 =?utf-8?B?WllGaExoSWlPcnA1LzBoQlBZQzdVUk9FakJXY2s1TzhxcDhZdTNyT3ZhTCty?=
 =?utf-8?B?Q25yUFNRb2lTK2tVK1hQRWlWU3BaWXFQQTJUODB4WnZtcEVoT1hqSG1EaG0x?=
 =?utf-8?B?WXJzMGFOMUpoRTFVcm81NGo1RGdnWi9aQWJkSkhsZzVlTTZicEJ5dXI3Z3JN?=
 =?utf-8?B?ZkhLQWV1Sm00YzVOdmwrTW9kWmsvMXFDSnBsOFVTOVNrOXBHelh0Y21TL0hS?=
 =?utf-8?B?b0dSUDlSSnViUFVyNkUweVJJeWkzTy9BVVl2dVhXSnN3dG1mRVFrWm1JMCtM?=
 =?utf-8?B?NHl4OXh1V252ZzBYcmMyVnNCelZqWnpjbDJPNGpXbUxIZnN3R29Kcnc1N0tD?=
 =?utf-8?B?SEp0Z01XOVZBRlpoaWZYN0hIcVc4b1dncVAvM3ZjZlE4eWJqSWp0cHRaU2lE?=
 =?utf-8?B?WDNEcVhqQjJ2WDNvZ0xXemZQN2J2dTc0VWt6WEl3aDE4WW1LKzU5eXhNNXNC?=
 =?utf-8?B?ajJheXBCSm9lZ3hKcFY4Z25KUFRZcE5jQXpua3dQdFJnM3VqZlRNNEt5Y0t4?=
 =?utf-8?B?MjB5d2lwekZQS1d5NFNKUUcwNjAvUndubmFrRFA4MElYTzdwKzBuNUo1eE4x?=
 =?utf-8?B?dmEzbmRBWGVsOVFCaTd1WFdDbHJJQ3lGZFI4TG9ObnhLUW8yMDQvd0ZraTZM?=
 =?utf-8?B?SGRRR3NLNGhDUGR2Rzcrc054ZFNhRUZLclRQNG5JSG9Lc3lNZC9vTU00Y3I0?=
 =?utf-8?B?aGpJbnRWTEpKdGk3K2JHTzNyR09XN080Q1ZCM1RYa1dmbXdjMSszRC85U0dN?=
 =?utf-8?B?UXh0T1htUStkWUxMcHUxS204NDgyMjhlN24rOENyVVZPelhjZzYrbjBHOHNC?=
 =?utf-8?B?TGlOaFZMSlV5R1RrTmRURHNxU2NoVmYvcEhwOU1IdUtUQlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmN4NjJtbzI5ZXZnYy9MQmxxZnNZT0E1dW5TRURTdFR4NEpYa1cxeDc3ZkFQ?=
 =?utf-8?B?bnlZZmlJY3BwREFEeG5wWFE3NThVVVdjQ2NodEd5czhOWE5uOTVtUjlDL0ZU?=
 =?utf-8?B?cFR4S3pzTUlFQXFJUkhQczNUd3VudkdZcEpIeGVOR3R4Q1lZQSt3QVpCUktI?=
 =?utf-8?B?SEZwT2dDdzMwU3pQRzJKMFNqZ1hyTzFLTzU2RlNHYUpONkw3RE9hZWo5TTZM?=
 =?utf-8?B?OWZIdEo1SHJEaGFQWmxCOEdHY1Fwa1VneXdidmJUQUFUdjVPSVRFTlk4RndM?=
 =?utf-8?B?UTB2ZVFOOW16Z2xWQmxGNmYrTExodGptNGtsWkppaHExS0hTZkptQ2EwOTNr?=
 =?utf-8?B?bzMyQURmSmpwYUViMmhJemVBaU9HMGZDcEJjNGxraFdsRi9mQVZubHV1cTZu?=
 =?utf-8?B?TkRDWnY3Z1huMHg3U0dLUG1Tcm5teHFra0hwc3lVY2M4ZkRUTjJkZzFmeGsv?=
 =?utf-8?B?S1kwa3diVHpSeGRqazBJUWZtNytNRE82bXExK1M1Z0l0TFg5Wjc3UFQ0T0tl?=
 =?utf-8?B?SzJhdDgzNThza2o0WXF2MVNjd3Vsb2U1R1NjRVZtQUlaS3VsN3hkQ3VQcmpL?=
 =?utf-8?B?Wi9LejBzTFBxdlBPNEhwYWkxLzh5ZWZrU0JBL09WY1AwWUJZUUQ0TURINStE?=
 =?utf-8?B?S1ZtMG43aHdrY09lWnNkSGN4eWg0VzJ0VUZ3QzRsNjhHelpsR2lEdFBWbFAv?=
 =?utf-8?B?RXZ4dTdvZU5ZNkU4OEVwbjZmQVBwaWJ4T3E0WnVRVm56WnhHSldjYkVudHJC?=
 =?utf-8?B?Mnh2Kys3aVJRb09obFJRek1TdWlUbnl0U3FyM252WkIyc2hqanp2UFBDdjNu?=
 =?utf-8?B?b0N2K0p2K1lKZ2Y4MWhUSTJRWmRmOWpxbDFKWVg0MVNRZVUzcnlGSWM0bWRS?=
 =?utf-8?B?MDhTN0FHbkM0T1FKWjV1QURUWFEyOXI2LzF4c2Y2TmlBMWN4L3pBckJHNEE1?=
 =?utf-8?B?UUFRdWYwb1hkZFp1Ym9oZ0FtWmxROCtWNnBQWnJISXM5K051SlI2M2d0T2Jy?=
 =?utf-8?B?a0d0L2tZelhSWWh0NDZDV2dDaHBrVmcwMGxhZXBKUG1yUDBybVBjWFV2M3NB?=
 =?utf-8?B?Y3F4alhrUm1rT01YVlB0ajRERGtaZWVMOExJOGROMUFPK25ZVnFWYkxUandJ?=
 =?utf-8?B?bmJ4QURGSmZUU0hjeGVGdWJpdURLZnVMQmErQjJ6QVVZeUQyV1BJWFprMmdK?=
 =?utf-8?B?UTEzazFLUm5qOFc1ZmRzUEVxSEtVRmc4V1lsRnJ2aU9aLzVpTURrby9uU2hK?=
 =?utf-8?B?YlRHZmRycHdtY1hqN3JBU1BEVDNtdVBRSTBjZlB0T1VNNWVFdE9URmxkSXMz?=
 =?utf-8?B?R3gzUmlrVDNTbFMrY3ZtYkJkamlzTnk3VXhGOW5KL0RjN3dCbkIreVFNRkZQ?=
 =?utf-8?B?WFpubUNyaFViM3dibTBqeDhKbTgrcFRoa29xdmgwS0lib1g2WVhtZVpFWUxB?=
 =?utf-8?B?enZkUGl0cTE3ZkRscmp3Yi8vVng4MWZQTyt3S25XYTNTd2kvTHk0aVVHUlpN?=
 =?utf-8?B?ZlFrZGx0SGw5TFNrLzZLd2d3YXZhWUJzbnJtbm9XL0o4eUVSVUNIUkp4RWpS?=
 =?utf-8?B?NlFhMXozVWhCMmxnYWJDV2ZEaGhtSUg1VXVBNll1Ty9VZVdDbldWcHNlcENE?=
 =?utf-8?B?MEVRV2lvZnpDQTNJdk1JUTQrVkVLZnBVTExsQWRRc21jcm5EVDd1YVdoNVJH?=
 =?utf-8?B?b1kzdnFRRlhHVjdVUk4rUTZkV1FKbjVtVmh4aUpRSncydXBUOUJ4dHozUmFn?=
 =?utf-8?B?VG5SblcwQUJ2VUx2MkFLNmVva0RXcDlPMll0WTRoRTBPRlFRZjNNWDRkbWxj?=
 =?utf-8?B?NkY1NW5DeWhlQ1c4M2xDU3NaOG1SZWd4UTllNGxuUUhwS3FybE5Ea2JaZEZ2?=
 =?utf-8?B?NHE4OEdtWVRTeVRyVU9BSnlBbUxMcnVkRTAweXBvVU9GRVFOaURvVFhlMUhW?=
 =?utf-8?B?V2hlNzV6S3d4TUN4ZkRRaDBCS0VMY3V2UGNVL3cveWN6VWNqSDVRRWJHTDR2?=
 =?utf-8?B?cGhwcjJFVGI1Ulduc3M3S0U2c2tyY0ozVEVnOEdSSndpSTFyL2I2eFVNRDFm?=
 =?utf-8?B?RXRFVFJ1ZmhsUDYrZU9yelVHb1RPRXZDNzVudmIxSzBZTXBwMEpuSUpDMWRW?=
 =?utf-8?B?amZTUDdORE5adEY5TURYUWEvcm4rWVoxSjZHTVhBS2l0c2wxcGo4M1hqQmsy?=
 =?utf-8?B?VVM0d3plUVRZdjBzNTVBMW9MS01ZRlY0MFFqNmJrVHRMWXNDRmFDbnpsRWYx?=
 =?utf-8?B?NWpONGFDQm56ZWk4SWdDOHJjU053PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4EBC1506CC8604DBCF942A9BC5B6F84@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad15c163-1fc9-4fb2-e3ec-08dcc1f1bc45
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 14:58:36.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gd7KEOKnShEjfAuJZA7v6QscQzhmFZxdIatEcBOGKT0Z1MKOldq+4AwGYu+0K5RocE5Vbxgvfdbz8QeeqqN/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5843

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDA4OjE2IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
SXQgb25seSBkZWNvZGVzIHRoZSBmaXJzdCB0d28gd29yZHMgYXQgdGhpcyBwb2ludC4gSGF2ZSBp
dCBkZWNvZGUgdGhlDQo+IHRoaXJkIHdvcmQgYXMgd2VsbC4gV2l0aG91dCB0aGlzLCB0aGUgY2xp
ZW50IGRvZXNuJ3Qgc2VuZCBkZWxlZ2F0ZWQNCj4gdGltZXN0YW1wcyBpbiB0aGUgQ0JfR0VUQVRU
UiByZXNwb25zZS4NCj4gDQo+IEZpeGVzOiA0M2RmNzExMGY0YTkgKCJORlN2NDogQWRkIENCX0dF
VEFUVFIgc3VwcG9ydCBmb3IgZGVsZWdhdGVkDQo+IGF0dHJpYnV0ZXMiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gRm91bmQgdGhp
cyB3aGlsZSB3b3JraW5nIG9uIHRoZSBkZWxzdGlkIHBhdGNoZXMgZm9yIG5mc2QuDQo+IC0tLQ0K
PiDCoGZzL25mcy9jYWxsYmFja194ZHIuYyB8IDQgKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMv
Y2FsbGJhY2tfeGRyLmMgYi9mcy9uZnMvY2FsbGJhY2tfeGRyLmMNCj4gaW5kZXggMjljNDlhN2U1
ZmUxLi4yNDY0NzAzMDYxNzIgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9jYWxsYmFja194ZHIuYw0K
PiArKysgYi9mcy9uZnMvY2FsbGJhY2tfeGRyLmMNCj4gQEAgLTExOCw3ICsxMTgsOSBAQCBzdGF0
aWMgX19iZTMyIGRlY29kZV9iaXRtYXAoc3RydWN0IHhkcl9zdHJlYW0NCj4gKnhkciwgdWludDMy
X3QgKmJpdG1hcCkNCj4gwqAJaWYgKGxpa2VseShhdHRybGVuID4gMCkpDQo+IMKgCQliaXRtYXBb
MF0gPSBudG9obCgqcCsrKTsNCj4gwqAJaWYgKGF0dHJsZW4gPiAxKQ0KPiAtCQliaXRtYXBbMV0g
PSBudG9obCgqcCk7DQo+ICsJCWJpdG1hcFsxXSA9IG50b2hsKCpwKyspOw0KPiArCWlmIChhdHRy
bGVuID4gMikNCj4gKwkJYml0bWFwWzJdID0gbnRvaGwoKnApOw0KPiDCoAlyZXR1cm4gMDsNCj4g
wqB9DQo+IMKgDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGIzMTFjMWI0OTdlNTFhNjI4YWE4
OWU3Y2I5NTQ0ODFlNWY5ZGNlZDINCj4gY2hhbmdlLWlkOiAyMDI0MDgyMS1uZnMtNi0xMS0xODhi
YjRlMWYxZGQNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0KV2h5IGRvIHdlIG5lZWQgdGhpcz8gSSdt
IG5vdCByZWFsbHkgdW5kZXJzdGFuZGluZyB3aGljaCBjYWxsYmFjaw0KYXR0cmlidXRlcyB3ZSdk
IHdhbnQgdG8gcmV0dXJuIGluIHRoYXQgcmFuZ2UuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K

