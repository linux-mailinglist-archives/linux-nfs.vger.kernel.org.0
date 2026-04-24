Return-Path: <linux-nfs+bounces-21079-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFF1Hnl062koNAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21079-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 15:47:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7045FA24
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18A230BAD19
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CB3D5241;
	Fri, 24 Apr 2026 13:41:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023109.outbound.protection.outlook.com [40.107.201.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216819A288;
	Fri, 24 Apr 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038068; cv=fail; b=kQVMWX1H1vVjKES54mFzNQch/qoH0xeY9ojr5oVN7Ddf+BJTVg8C9Fe6um5W0Jpw0yFQmNMDZy/SsZ+vlCWF+W5bfyO3gOATuFGveyPcctieKD7sD8nN07gElIeeLIlikXE/VNVSa7N+z1dV9TeOJk6zHqwmc/s9jJGZVKTybCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038068; c=relaxed/simple;
	bh=5TKTtGucEuy1kfK34Ed9TTy2BadII89sBzVilUr8WyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYO+UMQT8xBb3T+7ZWG6QPLAOEl6Q744vp3jknb3r8X9bruY1lcQSK49UB2EDRoEstq7mjWySinATQxWPJC8FYLaqTgE8HHivEslU9Qq1mTlnpBmMVepybH5XLMyhcFbVTNlmC7Ppx6El+fBI1AttYMUWLGRIRR95hmtxkONp9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.201.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcnQfCkiw2DQWxbOhmYMDzTokXtgdhF8Nt8/sb5lgOCu5UomojV4XhZHIgKvhVs5isGdjM96AEBToUMJi/ttUVCwCZEuuZjXQWWwUvLbzgHLvh4TkDKFkgClH+hsY9SAKtk5iaCCSBb4Eo+Q+Wq0nJzCtImdpVG+bM0QbKFDXP8jFsYaQTkgL5T2obhQxonG1SHBDwXb2dl5rphhF+4wWZOIW3FlxMPVk1qnkSkKj2Dj7UhQTgFuuHNnr3UVlXx7zeZA2SoNZ2JagzLAoKHyQ8VHwUiwWgVr9K8jx7Yz3RczYs5phym5nrWkmmQAmu6wXSX0+hCEXu5Vz0uCtTH0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neoSVMDXw3f2dtrBsFsm/v++HDlmtoue1uMtOVD+1b0=;
 b=HjW/x5DRgd5Z/b5lqoAYt1OeCKKf/1KgwoPxd5B49jAWtZQyXPcv/I4e1OuNBEwucLIrYx7E+IzvV83QYaeH80CaExbaJ/mbaZ8LKedtsULwX+RNwZ8wx/SAjzPQmWXrN/DrtQVuQTfzSmKSug+kQ9fIr8fzbbf6o91zH9zKz3dEU+u7HGgX1LYhyTdww+5d6KiJ5RIZ7dH0WzU/qn54rYAKDr0q+7+4a4kS/RAbql0BUkjp7MKm8ncWaC81iihxXVU8VSebVGEkA/4QXZKp1tdVANfE2KTmp+qDz+bT6I/zua42SiuL2RuW7MW1/0ZlGFfZbz6wAoj6u0iEkwo3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from MW4PR01MB6338.prod.exchangelabs.com (2603:10b6:303:7b::15) by
 SJ0PR01MB6320.prod.exchangelabs.com (2603:10b6:a03:291::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Fri, 24 Apr 2026 13:41:04 +0000
Received: from MW4PR01MB6338.prod.exchangelabs.com
 ([fe80::e7ad:d8fa:59db:4761]) by MW4PR01MB6338.prod.exchangelabs.com
 ([fe80::e7ad:d8fa:59db:4761%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 13:41:03 +0000
Message-ID: <e248f3de-bbaf-48e3-9e86-0beb9a789556@talpey.com>
Date: Fri, 24 Apr 2026 09:41:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: "Intent" of VFS lookups
To: Shyam Prasad N <nspmangalore@gmail.com>, Ralph Boehme <slow@samba.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org
References: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
 <438478a7-c965-4a2a-9c4a-84b5f77d6dbe@samba.org>
 <CANT5p=ortwT7ensa+kKoCa=wMnGETpqaQuBnhDWMSNu82KsqFg@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CANT5p=ortwT7ensa+kKoCa=wMnGETpqaQuBnhDWMSNu82KsqFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To MW4PR01MB6338.prod.exchangelabs.com
 (2603:10b6:303:7b::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6338:EE_|SJ0PR01MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3d3577-ff41-47af-df86-08dea2072122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X528O3kCcwDXBbtn6RGvtxoqsFYTkG/wU/aeFDt8ro7p4Pr278Vw8N4oVon8l0wq/9KIScbmIPsTeZRs+yWAKx3buJdwxOrvvf5tmTuk01aXFw76IDGABI6eFBi9uSx7Ygy2igF0ZbU+F6TNv4b54bbqYDX67V+N1D2A2/XqUdE5v8XWXRLJ5+d8cuUs9JokWDfBZg1Rim85gJT7jjW7+PWhWLO1PJiuUzUJUmHAtEUUbE8RYD3GibHyNNgPuWYiCdZ6drXhMEAtiAqgBebUx/A/nCeDZU6QYIKIXtz/TgyTNjPz4m38VJ9OSyCeJqhjk2vEVJhzsudJ0C6sLtZDkn8tLFYjn7XT/Jha367jzeKx45KsAQYJWmxAMI3Dl5yev/rbcDPxT0/siXS6RSobkIDB/rvGBd3mkiW/OYF5v1XVBPIMkI6tRkLwHRa5agbOcSnNoD2T/LdFS2a4eurZwC9pHdyVe4xpggDflvZQQCZJaNHMxQ3mdTkuofLhGmbaFAtBfoxYnZrrvPZivls/7VhmBz8it0oiYoEjxvR4StQWKBYEDFGyAFoW8Bd4JMKaUwqw6CelCrK5BVtrRvzjM1n5waj7+rm4QSxAa5hRTLkurIU80/t8OW9eaWoWmaiAG2bS+BBq03bLS11HczxbbOFpdYdEWuf1lWk3yu4WtEYy3wF5UGlwea73ARoPuTBvDkPEsEHVoGN9kMZFjeIiNwTHc/WQspLpNT5uyOQcycQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6338.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzc0QS9VV1RYbjR1MVYydEI2cUF2dU5aa1A2ZmEwcFptYytmU09Na2ZmZTRj?=
 =?utf-8?B?VWtlSTBNV0c3RUhnbjRJSUlBL0NCZHV3a2U4UExmN1pPMTlDZ3lOZnEzR1dy?=
 =?utf-8?B?ZkdTaHF5NWhiVnFxL1lpWnR1aDZwL0Rpa1FLbkpwSXZaYS8ydUVleEwvRk9V?=
 =?utf-8?B?SEJ5VzJDbGFBZjBEYlZ4VkM4bVR1QjJzQ1Q0cFhWMjRvTTRFaDhvMU9wR0lZ?=
 =?utf-8?B?NlE0N05UdnhKVVFVRk9nWW04M1Z3N3FKUEtJM3RPUVdIVWVQbERWRzQxdDdh?=
 =?utf-8?B?SXNDU1BTMkljL3N5em16NzA0T2lJL2xHMGNHN3RDcHBGb0NFazFQTnNndVEz?=
 =?utf-8?B?dFBxbWNkeUg0VVNZNTgyWnAxd3NEUDlMdk1Qb3d5RmtiS2YrTG5KdGY5QlIz?=
 =?utf-8?B?ZS83cGhaMktrWmdIbkVDMVZQbTV3TGhCdktyRFRpRk5qa0FJRHRBU245OUg3?=
 =?utf-8?B?M2tSaGJsNkFqQ0NvRzdvcUVDNytXZmU5dnJ2MU8zek01UlYvSlV4eFdJbzRY?=
 =?utf-8?B?MWJHZGdPRklxZGEyYjB2MWY2MVdWeHd4V3I4c2dLQkxrdTJjNU5yN3ZJU1g0?=
 =?utf-8?B?c2FtRWh1ZnBNTDZvdU1vNGxtbFlDV1VUdEFQYmhjRE5jaUY4akVJOFZyUnFY?=
 =?utf-8?B?eSs3WjlIN253djU0SEVoMnpPbE44SThDMWpoaHlXeld0VW1iTGI4RHIwdlZk?=
 =?utf-8?B?cXExS3R4SVBGSndDNW5laE41ejJqRUxsYlQyazdoTVF0UlJxTTFFRVNoeDhQ?=
 =?utf-8?B?NHlaR1JLdGQ5TXdiZkwvUCtVVGtsSm5mcUVXdFlqOUZBSG80akJLcGJPakd2?=
 =?utf-8?B?anJRZVU5bkd6SjgrN2JCTUd0aDVpU1FKenhVam9VUk9kdzlBVk5TY01GQlpG?=
 =?utf-8?B?SVdWSDdjVXF5U1dLV1FyZzBXSVorSThDUVltTEp6eXYyclVhNE0zdEhqVTFD?=
 =?utf-8?B?cTQ4bSszejJucEUyM29zNUh0UEpUZExXamZaamdjOHZON3dhc0U1WTVhWjNC?=
 =?utf-8?B?dzNZNjBSZ3RUWmYrSXhaSjF3ZjY2SHdVZmdWNzZPWlBUUVpBTERmNjJyNlJi?=
 =?utf-8?B?aVN1Z0dwSk1HMXZNK01PckdmMmNiZ3hkQzE5M1ZYNE9HaW9lendaTTQyVHJI?=
 =?utf-8?B?VWdXd0hORW5PaXFraHFReUVBenVYUTVMNEs2a01mL1BndDZnZ2tzdC9UdFU0?=
 =?utf-8?B?TkdXWU1qa1FuQlpZOWxxVWJyZGp5VkhZNVY1Z0lQaVVJamd0QWNsTDlQMmJR?=
 =?utf-8?B?djg0YnM4OEZ2cndxTVJ5QkRYcDlTRmlnRmc3d241S093Y0ZmVXhxb3crUEtk?=
 =?utf-8?B?aWJQYXpwMmM0dFdRLzBUcHBvbzg1TU9UNkMxNit3S3o0U2l2RzdDeHNiNEdX?=
 =?utf-8?B?bVVPQlEzaWdDYkcxczZCczZhT09BRlcvVURrb0R1aXVoOVF5R3FJSUFHMjZh?=
 =?utf-8?B?MVRwMmdvSWlrS0E3WFZRVWhnMUVvV0ZTNlk0ejdjNHJTVW1VWXZBOWgvV2JY?=
 =?utf-8?B?OUhHUXQ3Z2NtaUFHdVZCZUl4TFJVcWk1SG5nLzA5Yy9CUXY2R1phc0dDNWE3?=
 =?utf-8?B?NENFbE9Wa25Fa1dtb1lKb1NNUEtXeUp2dlZ0UEl0Q00wZmx2c0VuWWRYUUlK?=
 =?utf-8?B?U3RRd1MwWVcxbjl1Zjlac0Zuajk0bWtyT0pjb1Y1WWlvV3VSWFk2YVB5ZXZI?=
 =?utf-8?B?RlZ4N1FQUC9GMGl3L3hVTUtkOWp5cXA1YUI3M2xTbk9NM2tta0hlbGhnSTJm?=
 =?utf-8?B?cXVocHhOam50dnVmalNXV2gyVHV4VXgvUWRkUVJrdHk3TEJHNFFZMVcvR0JO?=
 =?utf-8?B?QnBvN2lJUXYzc2gvV3BWU3daTUUwMHpaNHloL2FLVFVzMVRLM3VhQ1NuSVZS?=
 =?utf-8?B?NGpvNTQ2d2FjSSs1RUoyVFV3UzdwYXptRVlQU1RKelhSVWQ3MXhmS1VMWlBF?=
 =?utf-8?B?SGN1LzVseEZ1MVFqVWxVMGJoZmFUazFnVk11NmNPai82eDIycnNLdHBBTzN1?=
 =?utf-8?B?MU5CaHMyT2dXWWFicjJ3TVJPMzdxN3RucUhjbHpUMTlhWFRXbU1LWTg0M1RV?=
 =?utf-8?B?TkNsY0wzN0JjSmN6VDM2YWhvcG55NjB0RktoWlpVN2lBVjhLb0dHd1RoRDhU?=
 =?utf-8?B?RVVpdmcraHdPcVJzYWwxNTdGazlaNTEwNmpXNi9sdWVubW11SjV4ZlJnNHBC?=
 =?utf-8?B?cW04YjZTOStMZ3Fjc0lORi8xTHJpamRTSEFlZ2NUVkFPckpXUmVNd25BcjZ0?=
 =?utf-8?B?YXc4L0tjYmlLbWkrcFNHS012ZllVRUd0NThOM0VPK081SFAwdTkvY2MxUHEr?=
 =?utf-8?Q?kUOgSEPUQToyVz5J0L?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3d3577-ff41-47af-df86-08dea2072122
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6338.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 13:41:03.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzwZuik0Iy42NbmW1dM0FQqI4F9ZoaieIs1kYdF4XIrQJSyOrkYm+9kwNOxuUa4u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6320
X-Rspamd-Queue-Id: DFF7045FA24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21079-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[talpey.com];
	FREEMAIL_TO(0.00)[gmail.com,samba.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@talpey.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:email]

On 4/24/2026 9:20 AM, Shyam Prasad N wrote:
> On Thu, Apr 23, 2026 at 11:13 PM Ralph Boehme <slow@samba.org> wrote:
>>
>> On 4/23/26 7:01 PM, Shyam Prasad N wrote:
>>> Wanted to understand if this is a problem for other filesystems or if
>>> it is specific to SMB protocol?
>>> SMB2+ protocol mandate that open call specifies if the file being
>>> opened is a directory or not (regular file).
>> sure? From memory (though the logic has always kind of escaped me) if
>> you neither specify FILE_DIRECTORY_FILE nor FILE_NON_DIRECTORY_FILE the
>> server is supposed to open the object regardless of the type.
> 
> Hi Ralph,
> 
> That's interesting. The spec does not seem to define this. Perhaps purposely?
> Will try and prototype a change to verify.

This would be filesystem behavior and therefore it would be in MS-FSA,
not in the SMB2/3 protocol.

MS-FSA does indeed specify that in certain conditions, an open must
succeed on a directory even if both DIRECTORY_FILE and NON_DIRECTORY_FILE
are false (page 60 section 2.1.5.1):

  If CreateOptions.FILE_DIRECTORY_FILE is TRUE then StreamTypeToOpen =
DirectoryStream.
 Else if StreamTypeNameToOpen is "$INDEX_ALLOCATION" then 
StreamTypeToOpen =
DirectoryStream.
 Else if CreateOptions.FILE_NON_DIRECTORY_FILE is FALSE, 
StreamNameToOpen is
empty, StreamTypeNameToOpen is empty, Open.File is not NULL, and 
Open.File.FileType is
DirectoryFile then StreamTypeToOpen = DirectoryStream.
 Else StreamTypeToOpen = DataStream

There are a bunch of other cases involving trailing separators, etc.

MS-FSA is, of course, not the only filesystem type which can be
exported by SMB.

Tom.

