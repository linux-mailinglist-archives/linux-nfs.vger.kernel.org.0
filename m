Return-Path: <linux-nfs+bounces-17483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81ACF7B54
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 11:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5794E303E691
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8230F950;
	Tue,  6 Jan 2026 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWxWuZTC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0130F951
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694359; cv=fail; b=Lm+tlCHSGUYm3MNK3QjTSJz3FkYMC/3L+z7hblTktEB17SaaSHAi7l5KkRwbrrPMRcoDHFE/W2FW5sSQ6JBZ+PDjIRFiOV/PrvooLftF68F+zrk/DJR401QEFU9U+4PDL4QfPVC9lqTwt95hd/bJ8QgoN14n3k8HWS1Jh3l8gF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694359; c=relaxed/simple;
	bh=cwiGVLMbsziXtnRIk24kxjmbI4tanZlpJmyFPrAFUfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qXonffY7CJ2+e43EoGzH+ksjUJXLzYZVcU8E1BZUPlf2wg2DzxW23VUCnh34ZQJ3mso1uX4/naG4oXPE9rPe/AOj69cJ9aStvgKgua1Ts212yA2lEUY51rG69bl7Zvix8xr87dDSn7dXc4SoSwAmjIJuIcedy/DEfWaWUyBzz1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWxWuZTC; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPeSHHZAM1FCUg6ecqtWk54P49bn9QKhtaxdPoSXk1lq8dId36BCnS3PaWJPQ0rPQXBCx2jBCWFqbDTyqZPnN8sSifqjhJyFBP0lRUD029nPbIBfWBKaKDSSoaPJBCNyraarxz7Vj7mXII5bAHwEAeDQYhwxshQKDtThxD3hhd1WhTsr52wmNaLneOxLc8yDvpjTDViEJQXRWMoeo+XkG0S57ROpUrENWc/hbrU2K+ia02F3Ga0qk0PuZAImwWMLY24EihNegJHitz6lFddHcLmpLzvvlY3L/NtMXBfOPzttPdk/SvQhhpk5seVnyN32Ux+wDqngstaPgqDbdga/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwiGVLMbsziXtnRIk24kxjmbI4tanZlpJmyFPrAFUfM=;
 b=k9nG4hnFml7nM90qDr3TvLUTcARZF1iMnpOBT2MQ/3bLCd4WFb4qLkt1gZ7lFK70r4usQdORefu69Ni2vMoyGOi25/1F8G4tfA0wZJkginRxehVi1BmmXtakQ298UpIBcvIug6pqa5bhEAFExQzQXEb3r6OlQuZwtrRH4kwkNpZGjmKiJpgI2JwvmenP9dib6hIg/IiCDoYQK/1OQQE90w9VpJN8tclEp/GrKvOm6Al1cEwUq8SVnkUrIqoP92G9UOSSyTsuc+3Yz8dCEXp/dBbm+SOGBYwAme5u7MgomperkkCl0j8Fq6cNmp/fvHK24UjGW8lkezLBGBzPYah+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwiGVLMbsziXtnRIk24kxjmbI4tanZlpJmyFPrAFUfM=;
 b=mWxWuZTCg3c/hOfs9+7SODZbNJAS7ZQc/ThJ03DAo2B2wQDAoGzpZobOsPFCe0vKJgdOEV+26qTxbH3f/RHf99RAWT9wvI4MHuts6HDVolygB0Yxo8xuiWsEtcCJKDEJ9NLZcfaANc67hX2qB3fdZo4G98WIivDQ46TYh+7hinWv6XY0ZeDqi+FSSgb6+h2YKHKTxukAk/jpbdI4bIk4ZSunNq5HFwUeJOF/zJKxo+JlXM8ElIeV69E0BvBTlCOgqQE1OiUtbzo2+NNt1fiAazp4zrmXaprbs3ZlacFoAiCeBIJjy+iyRzMgfRbStOqp05DvpVMaPVbynrURDdGwcg==
Received: from DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:12:33 +0000
Received: from DS2PR12MB9712.namprd12.prod.outlook.com
 ([fe80::e44f:d15b:2275:fcb9]) by DS2PR12MB9712.namprd12.prod.outlook.com
 ([fe80::e44f:d15b:2275:fcb9%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 10:12:33 +0000
From: Bar Friedman <bfriedman@nvidia.com>
To: Trond Myklebust <trondmy@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Riad
 Abu Ra Ed <riada@nvidia.com>
CC: Linoy Ganti <lganti@nvidia.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
Thread-Topic: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
Thread-Index: AQHcfVrJQs7En5G/Kkm2RYg17clUr7VCJSsAgAF3fQCAABYoAIABPEFv
Date: Tue, 6 Jan 2026 10:12:33 +0000
Message-ID:
 <DS2PR12MB97124A12DBC3EAE91A5DF9A8D487A@DS2PR12MB9712.namprd12.prod.outlook.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
	 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
	 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
 <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
In-Reply-To: <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: riada@nvidia.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR12MB9712:EE_|DS4PR12MB9610:EE_
x-ms-office365-filtering-correlation-id: 40fb2fb5-62c1-430b-c82f-08de4d0c1bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?mok5DOGHqyHZ2Wvv8PqWVYSjy/RUpGIiusiq/HWGya+7YTxJ3In6aPik?=
 =?Windows-1252?Q?Hm7ncK4jbuUFQkjD5KGkdB3EhVlOzBgoxFeLGIyBzjTVFPMRbwRsP+ss?=
 =?Windows-1252?Q?Lc+Sj5vM+xdhu9mKTxzWeG0RM+ayl0SC0VQmowQSpPHZo4IdUu94RYgs?=
 =?Windows-1252?Q?c7NV/JtM+aVChR366YY/eitIA5f6iQpVh4g/Ip6iYKbOcs+vF9tKjBzE?=
 =?Windows-1252?Q?AJGki76g+BYv2ymcdAx8511GKJRWuM6uos31PfUUgZW8W2bpbpps3TTt?=
 =?Windows-1252?Q?2A0VgG2sPotw/w9+7SoFXe0oMO9EEdl8HW0NAYiSbIsMJEr6CkirxWdM?=
 =?Windows-1252?Q?nd8wIERYBjW2xdFcrvTVWl5YkW5SIUAwlBNIS1LzyU7yCiarHOIujriW?=
 =?Windows-1252?Q?+QhvBkjsH3kVwnyu93zhCa9vtBlF0Vxv50XeVSxvzyyPnd84y53rFquf?=
 =?Windows-1252?Q?FjCBJEdCqRX2j9HMQylV6DoNBqwh+g/rF6x2dCY1Kw21Oc6aQlN5wxzu?=
 =?Windows-1252?Q?wMxG/hKhuSqEq64FAA6KPp+DXVx4QQ1r1YbL7IJi/cE/cDR1E4UGlkpl?=
 =?Windows-1252?Q?YRHIxSqC7xOop7er7sv3xvgM5mKD4GzjYRQol3LaIThruiWpYb3z3qLk?=
 =?Windows-1252?Q?dD8v5PPl4AVTfCiUokZIa1OK8nH6wyPPZacbDH6cBSAicC0csP6MeSgm?=
 =?Windows-1252?Q?gYCkZSdB7QIebeWyWwufaMmVUQ4wZGOW9WgbwJFhiD7JriDbJipo3tr8?=
 =?Windows-1252?Q?Dv0zTh3X8dz7hplxff3QuBLEQVtDwPXw6iVbkOKF922Lso20ukSE9Cyh?=
 =?Windows-1252?Q?0FiBgA/2arkYGZRXY2IWfiShBMKwo/0hlTQHxZQ1zAzpUZEypNTaZ/JD?=
 =?Windows-1252?Q?IHh3dyAhvwC6B63OLkNP0aFzzjt5AD2dRDZ64uErqmYxR3nabjF1fe3z?=
 =?Windows-1252?Q?4b3Lt0LaFV/AfjO8TuDXiCtiNjM0wVJ1YKFktAOIQpaSe0YX95ooQhlr?=
 =?Windows-1252?Q?lLH5rmU0v0y5BenSgwo9vA4ElBHBvGgj7vsF3sPIeiW43wXJvKXjAJzR?=
 =?Windows-1252?Q?X9R6DLzY2BSgzCA9c0Uu4wwod6gjwKghVrUT4BowMJgZ61boF2s8QMLV?=
 =?Windows-1252?Q?4B10XM05P5ifbo0CI3QsMeVyKGOJA+nskrNKn0tcXvS/CJnkjN/Kt71h?=
 =?Windows-1252?Q?0F4g9FRFRN5UBM8qZ+Y/QNB5bVK4C3+wHj02ALfNwC7vqaZvpWrUxywW?=
 =?Windows-1252?Q?BiVzMH/ASoZUm++O6OTG5QXwow4s1u9y49kX0A1dTMYQFPrHJma0C0MS?=
 =?Windows-1252?Q?CxKy38qAZZ+vkvPxoUKZ3J413kW7RVrmFh0bE/fgrPOdUEyBVhQ7XXKg?=
 =?Windows-1252?Q?KYKXJa3E86YF2NM8hul8DHsHINMqZI968fOakphXCOCCoPjZeB3xtYs2?=
 =?Windows-1252?Q?KYIvqcsk1h4pOs4gbyH+v5wQnHxrZRl0H8pCLe4tagrhg1phZbav4gZn?=
 =?Windows-1252?Q?VjztvywfwM26DH+P1ZIgD9VqObo2J0J2udk3g1wWzYIGLPkkhEiXi21B?=
 =?Windows-1252?Q?dVtfQIhScRSWQsrK9APvhl2JgoqtsYOYeDyrdugl1n6hMmMLklzVI4wX?=
 =?Windows-1252?Q?Sn75MbYUqLtAMtnyAyaizVIP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?aKoH4SgvCeQ/iqZr/54VIKxJwlI8HgmTG8LGuNKWqUYbx1yCDeph0rUa?=
 =?Windows-1252?Q?gqXETf4btpNYR+BxPex5b+/5GwkOdM0fLhwMtt8HufiPOo8KRHNVMjtb?=
 =?Windows-1252?Q?fgW8byt+NnkWqX6v7iCrzc/iPkt38AmiM388m13IytpJGOl5KvwlnIwe?=
 =?Windows-1252?Q?lepZZatXf/Ut0zc9YH0gQq8EWnzSSUZ9GGg4m9NthWaRpr1slQrVJcE7?=
 =?Windows-1252?Q?fQngP2NJxJuqA5hzmoYyaDQp5UEZTeN3SoN7jmK2Xj99e2byxiiNjXRg?=
 =?Windows-1252?Q?/Pz8tn0W/M3MY27y9pjiRQ5i7UzoHmS7IZoFA4lhFQ9YDLCIvoprSwaQ?=
 =?Windows-1252?Q?6fsTFPfNYaP+nphyac87EC61FGVJjcl8fBay5pBQf0p5rn7syMZBOdxx?=
 =?Windows-1252?Q?RefVWh2308CYOmrglEa3s63WTkpYgILQdiU7xNflJqpehaESSuWva8sX?=
 =?Windows-1252?Q?+6fygGN5kVYut11d8beL/lVT+sjWlYuQwJkn/HZVGKpd3uEMGddHWO5L?=
 =?Windows-1252?Q?HFILyQFcrVNfqhEG7beCArGINq5EgBvTZt5VkmNZYxwxT7c6N5VzHvlT?=
 =?Windows-1252?Q?CtL+QL3IyEu8XjGwQEvSlMOv5T5proIUh7V2miCp1bjcfh4LvvfsW1pR?=
 =?Windows-1252?Q?8WtaB2JcQsKVtK5htg9lPBpqSyFPW/E5Qp4Nig6LB8RDtaKTyaXk09+4?=
 =?Windows-1252?Q?PjdnKqsgz1FM6w/PhlgwNLgkMRBnJRZ0lN5PA/VPwtQIbkm7qYq6GjGz?=
 =?Windows-1252?Q?6YrWp102T2fUZBjAkEpXV/7HnsQDK3WpRFsXERI4oGsRVrkbKcoF076R?=
 =?Windows-1252?Q?HdGhl+mXOKrXD70F7upW9Q2412x/yL2ti6Be6FK3XwgxM3UjscffPX+T?=
 =?Windows-1252?Q?RMXBZMVyG/5UwxMxCt3niITzEoZUjoYhWLVzFb1WD3O8hKy/eCKpEmEt?=
 =?Windows-1252?Q?bSNUuPyNBkJbqO7Ev8yP91Qt8XxhSb5looZVXYBh57RF4PkDVtcMXJlR?=
 =?Windows-1252?Q?YPgNSxNFm2dcjMk15r92Gxg6sL+SjPNLfod7+XCogogGjQ0ntwU+G9PR?=
 =?Windows-1252?Q?yOFqnXXJKWB6kewO6n2wiH+UcJAxZ88wLwQRUBcgnEesw6W2RbzDVbrW?=
 =?Windows-1252?Q?R1cY8TAh6B7YPjcwD+XqAmQa4KKKnqdXkonQ5UNbmaP8TiXEEC2vKOsL?=
 =?Windows-1252?Q?mBT8Yk8p/8yD8SMgdm2xuK3nMTR1ZHMFDtY7s7n+vh9LBCZSqEClwF1b?=
 =?Windows-1252?Q?m/3vHGTAQq7C+BBcVslpE045W5KD1p2eVgbQLvALTryL9S1NR1XoovAk?=
 =?Windows-1252?Q?twrFSJsT5bnOYtLUhpJ9AJ9ehYjnuYcki84KSPVSje7zOOQ55O2jwLDj?=
 =?Windows-1252?Q?aMSTWxjb0bgVtykUAwV/MviWz+nCvT9RxX9NXqVe0kk9ssYdTKFVdazA?=
 =?Windows-1252?Q?EhYjzC7e8bEZAgDNqxZshiP9iVKRGyXjlDIXpaw+5jTkx0iHCKuntuf3?=
 =?Windows-1252?Q?bYwMEM9/VMP7jUplmnZe3/eGKEXwN2Mv4qXhZ/vWMW6mE3dcaI7VDvtf?=
 =?Windows-1252?Q?tzFwfDTZ4eWuPh7r04vEoHvJdNMPDPva5VvzHPkWVJodv7vUaIfcV5ze?=
 =?Windows-1252?Q?hO49/+OT9MpilQVSzalLwDMfXIAoMX96uwnP5vTei8o171V6gnqcvSUb?=
 =?Windows-1252?Q?opeSPzR8YdoRBtbQ8vIs1ojePenD2TuyH3dXQo6Dc261au8ZJTpEysz5?=
 =?Windows-1252?Q?Q/vN2Py0TL+iSCnCMbkm8O1BwtqVNXf1XUfHzfk7wFlIWbAR5mN/FaqX?=
 =?Windows-1252?Q?LTBg06avdxh8gIleWmTud2rCQsQ1fQ/Gg4xhskPlm8DDQDxZ?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fb2fb5-62c1-430b-c82f-08de4d0c1bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 10:12:33.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0zW3sLV9bemIo/FANCXdPxaTod9sUJaPjxkMPgUn98T3a0n/xNfjXIqX6pPASXB18BM3fpRA2W8MoAxZ7rfRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610

+@Riad Abu Ra Ed=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Trond Myklebust <trondmy@kernel.org>=0A=
Sent:=A0Monday, January 5, 2026 5:20 PM=0A=
To:=A0Mark Bloch <mbloch@nvidia.com>=0A=
Cc:=A0Linoy Ganti <lganti@nvidia.com>; Bar Friedman <bfriedman@nvidia.com>;=
 linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>; Maor Gottlieb <maor=
g@nvidia.com>=0A=
Subject:=A0Re: Possible regression after NFS eof page pollution fix (ext4 c=
hecksum errors)=0A=
=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
On Mon, 2026-01-05 at 16:00 +0200, Mark Bloch wrote:=0A=
=0A=
>=0A=
=0A=
>=0A=
=0A=
> On 04/01/2026 17:36, Trond Myklebust wrote:=0A=
=0A=
> > On Sun, 2026-01-04 at 11:16 +0200, Mark Bloch wrote:=0A=
=0A=
> > > Hi Trond,=0A=
=0A=
> > >=0A=
=0A=
> > > We=92ve recently started seeing filesystem issues in our internal=0A=
=0A=
> > > regression runs, and we were able to bisect the problem down to=0A=
=0A=
> > > the following commit:=0A=
=0A=
> > >=0A=
=0A=
> > > commit b1817b18ff20e69f5accdccefaf78bf5454bede2=0A=
=0A=
> > > Author: Trond Myklebust <trond.myklebust@hammerspace.com>=0A=
=0A=
> > > Date:=A0=A0 Thu Sep 4 18:46:16 2025 -0400=0A=
=0A=
> > >=0A=
=0A=
> > >=A0=A0=A0=A0 NFS: Protect against 'eof page pollution'=0A=
=0A=
> > >=0A=
=0A=
> > >=A0=A0=A0=A0 This commit fixes the failing xfstest 'generic/363'.=0A=
=0A=
> > >=0A=
=0A=
> > >=A0=A0=A0=A0 When the user mmaps() an area that extends beyond the end=
 of=0A=
=0A=
> > > file, and=0A=
=0A=
> > >=A0=A0=A0=A0 proceeds to write data into the folio that straddles that=
=0A=
=0A=
> > > eof,=0A=
=0A=
> > > we're=0A=
=0A=
> > >=A0=A0=A0=A0 required to discard that folio data if the user calls som=
e=0A=
=0A=
> > > function that=0A=
=0A=
> > >=A0=A0=A0=A0 extends the file length.=0A=
=0A=
> > >=0A=
=0A=
> > >=A0=A0=A0=A0 Signed-off-by: Trond Myklebust=0A=
=0A=
> > > <trond.myklebust@hammerspace.com>=0A=
=0A=
> > >=0A=
=0A=
> > >=0A=
=0A=
> > > After this change, we intermittently see EXT4 checksum-related=0A=
=0A=
> > > errors=0A=
=0A=
> > > during boot.=0A=
=0A=
> > > A representative dmesg excerpt is below:=0A=
=0A=
> > >=0A=
=0A=
> > >=A0 [ 1908.365537] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1908.375449] EXT4-fs error (device vda2):=0A=
=0A=
> > > __ext4_find_entry:1624:=0A=
=0A=
> > > inode #263414: comm updatedb: checksumming directory block 0=0A=
=0A=
> > >=A0 [ 1908.382985] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1908.389289] EXT4-fs error (device vda2):=0A=
=0A=
> > > __ext4_find_entry:1624:=0A=
=0A=
> > > inode #263414: comm updatedb: checksumming directory block 0=0A=
=0A=
> > >=A0 [ 1909.598811] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #423753: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1909.604308] EXT4-fs error (device vda2):=0A=
=0A=
> > > htree_dirblock_to_tree:1051: inode #423753: comm updatedb:=0A=
=0A=
> > > Directory=0A=
=0A=
> > > block failed checksum=0A=
=0A=
> > >=A0 [ 1909.958470] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #423759: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1909.963825] EXT4-fs error (device vda2):=0A=
=0A=
> > > htree_dirblock_to_tree:1051: inode #423759: comm updatedb:=0A=
=0A=
> > > Directory=0A=
=0A=
> > > block failed checksum=0A=
=0A=
> > >=A0 [ 1909.985956] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #303617: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1909.991371] EXT4-fs error (device vda2):=0A=
=0A=
> > > __ext4_find_entry:1624:=0A=
=0A=
> > > inode #303617: comm updatedb: checksumming directory block 0=0A=
=0A=
> > >=A0 [ 1910.156415] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #423761: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1910.161959] EXT4-fs error (device vda2):=0A=
=0A=
> > > htree_dirblock_to_tree:1051: inode #423761: comm updatedb:=0A=
=0A=
> > > Directory=0A=
=0A=
> > > block failed checksum=0A=
=0A=
> > >=A0 [ 1910.171364] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #423735: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1910.177292] EXT4-fs error (device vda2):=0A=
=0A=
> > > htree_dirblock_to_tree:1051: inode #423735: comm updatedb:=0A=
=0A=
> > > Directory=0A=
=0A=
> > > block failed checksum=0A=
=0A=
> > >=A0 [ 1910.267721] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #423744: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1910.281838] EXT4-fs error (device vda2):=0A=
=0A=
> > > htree_dirblock_to_tree:1051: inode #423744: comm updatedb:=0A=
=0A=
> > > Directory=0A=
=0A=
> > > block failed checksum=0A=
=0A=
> > >=A0 [ 1910.476906] EXT4-fs warning (device vda2):=0A=
=0A=
> > > ext4_dirblock_csum_verify:375: inode #423751: comm updatedb: No=0A=
=0A=
> > > space=0A=
=0A=
> > > for directory leaf checksum. Please run e2fsck -D.=0A=
=0A=
> > >=A0 [ 1910.482403] EXT4-fs error (device vda2):=0A=
=0A=
> > > htree_dirblock_to_tree:1051: inode #423751: comm updatedb:=0A=
=0A=
> > > Directory=0A=
=0A=
> > > block failed checksum=0A=
=0A=
> > >=0A=
=0A=
> > > The issue has so far only been observed in tests that use a=0A=
=0A=
> > > nested VM=0A=
=0A=
> > > setup.=0A=
=0A=
> > > It does not reproduce deterministically, roughly half of the=0A=
=0A=
> > > nested=0A=
=0A=
> > > VM boots trigger the problem.=0A=
=0A=
> > >=0A=
=0A=
> > > Would you mind taking a look or pointing us in the right=0A=
=0A=
> > > direction?=0A=
=0A=
> > > Please let us know if additional information, testing,=0A=
=0A=
> > > or instrumentation would be helpful.=0A=
=0A=
> > >=0A=
=0A=
> > > Thanks,=0A=
=0A=
> > > Mark=0A=
=0A=
> >=0A=
=0A=
> > I'm having trouble seeing how those issues can be related unless=0A=
=0A=
> > ext4=0A=
=0A=
> > and NFS are somehow sharing the same folios. Does reverting just=0A=
=0A=
> > commit b1817b18ff20 and b2036bb65114 actually fix the ext4 problem?=0A=
=0A=
>=0A=
=0A=
> Yes, after reverting those two commits we no longer can reproduce it.=0A=
=0A=
>=0A=
=0A=
> >=0A=
=0A=
> > What does "nested VM" mean in this situation, and what is the=0A=
=0A=
> > storage=0A=
=0A=
> > for the ext4 filesystem that is being corrupted?=0A=
=0A=
> >=0A=
=0A=
>=0A=
=0A=
> Probably should have explained better, let me do that now.=0A=
=0A=
> Say we have host A.=0A=
=0A=
> On host A we run VM B.=0A=
=0A=
> Inside VM B we run VM C.=0A=
=0A=
>=0A=
=0A=
> Inside VM B we have a mount (nfs one)=0A=
=0A=
> X:/images/.libvirt on /images/.libvirt type nfs4=0A=
=0A=
> (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat=0A=
=0A=
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3DY,=0A=
=0A=
> local_lock=3Dnone,addr=3DX)=0A=
=0A=
>=0A=
=0A=
> which holds the .img files. We launce QEMU with something like this:=0A=
=0A=
>=0A=
=0A=
> {"driver":"file","filename":"/images/.libvirt/linux-VAGRANTSLASH-=0A=
=0A=
> upstream_Z.img","node-name":"libvirt-2-storage","auto-read-=0A=
=0A=
> only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-=0A=
=0A=
> format","read-only":true,"driver":"qcow2","file":"libvirt-2-=0A=
=0A=
> storage","backing":null} -blockdev=0A=
=0A=
> {"driver":"file","filename":"/images/.libvirt/Y.img","node-=0A=
=0A=
> name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}=0A=
=0A=
>=0A=
=0A=
> inside VM C, it's a regular ext4 mount:=0A=
=0A=
> /dev/vda2 on / type ext4 (rw,relatime)=0A=
=0A=
>=0A=
=0A=
> Mark=0A=
=0A=
>=0A=
=0A=
=0A=
=0A=
OK so if I'm understanding correctly, this is organised as ext4=0A=
=0A=
partitions that are stored in qcow2 images that are again stored on a=0A=
=0A=
NFSv4.2 partition.=0A=
=0A=
=0A=
=0A=
Do these qcow2 images have a file size that is fixed at creation time,=0A=
=0A=
or is the file size dynamic?=0A=
=0A=
Also, does changing the "discard" option from "unmap" to "ignore" make=0A=
=0A=
any difference to the outcome?=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
Trond Myklebust=0A=
=0A=
Linux NFS client maintainer, Hammerspace=0A=
=0A=
trondmy@kernel.org, trond.myklebust@hammerspace.com=0A=
=0A=

